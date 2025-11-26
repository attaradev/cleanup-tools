# Homebrew Tap Setup Guide

This guide will help you set up a Homebrew tap for the cleanup tool.

## Prerequisites

- A GitHub account
- The cleanup repository at `github.com/attaradev/cleanup-tools`

## Steps

### 1. Create a Homebrew Tap Repository

Create a new GitHub repository named `homebrew-cleanup`:

```bash
# Repository name MUST follow the pattern: homebrew-<formulaname>
# Create at: https://github.com/attara/homebrew-cleanup
```

### 2. Initialize the Tap Repository

```bash
# Clone the new repository
git clone https://github.com/attara/homebrew-cleanup.git
cd homebrew-cleanup

# Create Formula directory
mkdir -p Formula

# Copy the formula from this repo
cp ../cleanup-tools/Formula/cleanup.rb Formula/

# Commit and push
git add Formula/cleanup.rb
git commit -m "Initial cleanup formula"
git push origin main
```

### 3. Set Up GitHub Actions Secrets

For automatic releases and tap updates, add these secrets to your cleanup-tools repository:

#### Required for Homebrew Auto-Update

- `TAP_REPO_TOKEN`: Personal Access Token with `repo` scope to push to homebrew-cleanup

#### Optional for macOS Notarization

- `AC_USERNAME`: Apple ID email
- `AC_PASSWORD`: App-specific password (not your Apple ID password!)
- `AC_TEAM_ID`: Your Apple Developer Team ID
- `CODESIGN_IDENTITY`: Your Developer ID Application certificate name

To add secrets:

1. Go to: `https://github.com/attaradev/cleanup-tools/settings/secrets/actions`
2. Click "New repository secret"
3. Add each secret

### 4. Create the First Release

```bash
# In your cleanup-tools directory
cd cleanup-tools

# Bump the version (this will create a tag)
./cleanup version patch

# Push the tag to trigger the release workflow
git push && git push --tags
```

The GitHub Actions workflow will:

1. Run tests and linting
2. Create a GitHub Release
3. Build and upload the tarball
4. Notarize the binary (if secrets configured)
5. Automatically update your Homebrew tap

## Usage

Once set up, users can install cleanup with:

```bash
# Add the tap
brew tap attara/cleanup

# Install cleanup
brew install attara/cleanup/cleanup

# Or in one command
brew install attara/cleanup/cleanup
```

## Updating the Formula

The formula is automatically updated by the CI pipeline when you:

1. Run `./cleanup version [patch|minor|major]`
2. Push the tag: `git push --tags`

The release workflow will automatically update the Homebrew tap repository.

## Manual Formula Update

If you need to manually update the formula:

```bash
# Calculate the SHA256
shasum -a 256 cleanup-X.Y.Z-macos.tar.gz

# Update Formula/cleanup.rb in homebrew-cleanup repo
# Update: url, sha256, and version fields
```

## Testing the Formula Locally

```bash
# Audit the formula
brew audit --strict Formula/cleanup.rb

# Test installation
brew install --build-from-source Formula/cleanup.rb

# Test the installed tool
cleanup --version
cleanup --dry-run
```

## Troubleshooting

### Tap not found

- Ensure repository name is `homebrew-cleanup` (not `cleanup-homebrew`)
- Repository must be public or you must authenticate

### Formula not found

- Check that `Formula/cleanup.rb` exists in the repository
- Formula class name must match file name (case-sensitive)

### SHA256 mismatch

- Regenerate SHA256: `shasum -a 256 <tarball>`
- Update formula with correct hash

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Tap Documentation](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
- [GitHub Actions for Homebrew](https://docs.brew.sh/Homebrew-and-GitHub-Actions)
