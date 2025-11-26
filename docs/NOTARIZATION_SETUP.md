# macOS Notarization Setup Guide

This guide will help you set up macOS notarization for the cleanup tool, which is required for distribution outside the App Store.

## Overview

macOS notarization is Apple's automated process for scanning software for malicious content. Starting with macOS Catalina, all software distributed outside the Mac App Store must be notarized.

## Prerequisites

1. **Apple Developer Account** (paid, $99/year)
   - Sign up at: <https://developer.apple.com/programs/>

2. **Developer ID Certificate**
   - Type: "Developer ID Application"
   - Used to code-sign the script

3. **App-Specific Password**
   - Required for automated notarization
   - Different from your Apple ID password

## Step 1: Obtain Developer ID Certificate

### On macOS

1. Open **Keychain Access**
2. Menu: **Certificate Assistant** → **Request a Certificate from a Certificate Authority**
3. Enter your email and name
4. Select: **Saved to disk**
5. Save the Certificate Signing Request (CSR)

### On Apple Developer Portal

1. Go to: <https://developer.apple.com/account/resources/certificates/list>
2. Click **+** to create a new certificate
3. Select: **Developer ID Application**
4. Upload your CSR file
5. Download the certificate
6. Double-click to install in Keychain

### Verify Installation

```bash
# List available signing identities
security find-identity -v -p codesigning

# Look for: "Developer ID Application: Your Name (TEAM_ID)"
```

## Step 2: Create App-Specific Password

1. Go to: <https://appleid.apple.com/account/manage>
2. Sign in with your Apple ID
3. Navigate to **Security** → **App-Specific Passwords**
4. Click **+** to generate a new password
5. Label it: "cleanup-notarization"
6. **Save this password** - you'll only see it once

## Step 3: Find Your Team ID

```bash
# Method 1: Using xcrun
xcrun altool --list-providers -u "your@email.com" -p "app-specific-password"

# Method 2: From Developer Portal
# Go to: https://developer.apple.com/account
# Your Team ID is shown in the top right
```

## Step 4: Configure GitHub Secrets

Add these secrets to your GitHub repository:

Go to: `https://github.com/attaradev/cleanup-tools/settings/secrets/actions`

### Required Secrets

1. **AC_USERNAME**
   - Value: Your Apple ID email
   - Example: `developer@example.com`

2. **AC_PASSWORD**
   - Value: The app-specific password from Step 2
   - Example: `abcd-efgh-ijkl-mnop`

3. **AC_TEAM_ID**
   - Value: Your 10-character Team ID
   - Example: `A1B2C3D4E5`

4. **CODESIGN_IDENTITY**
   - Value: Your Developer ID certificate name
   - Example: `Developer ID Application: John Doe (A1B2C3D4E5)`
   - Get exact name from: `security find-identity -v -p codesigning`

### Adding Secrets

For each secret:

1. Click **New repository secret**
2. Enter the **Name** (e.g., `AC_USERNAME`)
3. Paste the **Value**
4. Click **Add secret**

## Step 5: Test Notarization Locally

Before pushing, test the notarization process locally:

```bash
# Install gon (notarization tool)
brew install mitchellh/gon/gon

# Create test configuration
cat > gon.hcl <<EOF
source = ["./cleanup"]
bundle_id = "dev.attara.cleanup"

sign {
  application_identity = "Developer ID Application: Your Name (TEAMID)"
}

zip {
  output_path = "cleanup-notarized.zip"
}

apple_id {
  username = "your@email.com"
  password = "@env:AC_PASSWORD"
  provider = "TEAMID"
}
EOF

# Export password
export AC_PASSWORD="your-app-specific-password"

# Run notarization
gon gon.hcl
```

### Expected Output

```markdown
==> Signing files...
    signing: ./cleanup
==> Zipping files...
    created: cleanup-notarized.zip
==> Uploading files...
    uploaded: cleanup-notarized.zip
==> Waiting for notarization...
    status: in progress
    status: success
==> Stapling notarization...
    stapled: cleanup-notarized.zip
```

## Step 6: Trigger Automated Release

Once configured, notarization happens automatically:

```bash
# Bump version (creates tag)
./cleanup version patch

# Push to trigger release workflow
git push && git push --tags
```

The GitHub Actions workflow will:

1. Build the release
2. Sign with your Developer ID
3. Upload to Apple for notarization
4. Wait for approval (~5-10 minutes)
5. Staple the notarization ticket
6. Create GitHub Release with notarized binary

## Verification

Users can verify the notarization:

```bash
# Check code signature
codesign -dv --verbose=4 cleanup

# Check notarization
spctl -a -vv -t install cleanup
```

Expected output:

```markdown
cleanup: accepted
source=Notarized Developer ID
```

## Troubleshooting

### "No Developer ID certificate found"

**Solution**: Verify certificate is installed:

```bash
security find-identity -v -p codesigning
```

If missing, re-download and install from Apple Developer Portal.

### "Invalid credentials"

**Solutions**:

1. Verify Apple ID email is correct
2. Generate a new app-specific password
3. Check Team ID matches your developer account
4. Ensure 2FA is enabled on Apple ID

### "Unable to notarize"

**Common causes**:

1. Script must be executable: `chmod +x cleanup`
2. Bundle ID must be unique: `dev.attara.cleanup`
3. Check Apple Developer account is active and paid
4. Verify no pending agreements at <https://developer.apple.com/account>

### "Notarization in progress" times out

**Solution**: Apple's notarization can take 5-30 minutes. The workflow will wait up to 45 minutes. Check status manually:

```bash
# Get request UUID from workflow logs
xcrun altool --notarization-info <UUID> \
  -u "your@email.com" \
  -p "app-specific-password"
```

## Security Best Practices

1. **Never commit secrets to git**
   - Use GitHub Secrets only
   - Never hardcode passwords

2. **Rotate app-specific passwords regularly**
   - Revoke old passwords when not in use
   - Generate new ones for each service

3. **Limit certificate access**
   - Keep certificate private key secure
   - Don't share .p12 files

4. **Use CI/CD for signing**
   - Don't sign locally for releases
   - Let GitHub Actions handle signing

## Resources

- [Apple Notarization Guide](https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution)
- [Gon Documentation](https://github.com/mitchellh/gon)
- [Code Signing Guide](https://developer.apple.com/documentation/security/code_signing_services)
- [App-Specific Passwords](https://support.apple.com/en-us/HT204397)

## Optional: Notarization Without Paid Account

If you don't have a paid Apple Developer account, the script will still work but won't be notarized. Users will need to:

1. Right-click the script
2. Select "Open With" → "Terminal"
3. Click "Open" when prompted

Or use:

```bash
sudo xattr -rd com.apple.quarantine cleanup
```

The CI workflow gracefully handles missing notarization secrets and continues without failing.
