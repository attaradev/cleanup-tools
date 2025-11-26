# Quick Start Guide

Get up and running with cleanup in 5 minutes!

## Installation

### Option 1: Homebrew (Recommended)

```bash
brew tap attara/cleanup
brew install attara/cleanup/cleanup
```

### Option 2: Direct Download

```bash
# Download latest release
curl -L https://github.com/attaradev/cleanup-tools/releases/latest/download/cleanup-*-macos.tar.gz | tar xz

# Move to your PATH
sudo mv cleanup /usr/local/bin/
sudo chmod +x /usr/local/bin/cleanup
```

### Option 3: Clone Repository

```bash
git clone https://github.com/attaradev/cleanup-tools.git ~/bin
chmod +x ~/bin/cleanup

# Add to PATH (add to ~/.zshrc or ~/.bashrc)
export PATH="$HOME/bin:$PATH"
```

## First Run

### 1. Check Version

```bash
cleanup --version
```

### 2. Preview What Would Be Cleaned (Dry-Run)

```bash
cleanup --dry-run
```

This shows you what would be cleaned without actually deleting anything. **Always run this first!**

### 3. Run Cleanup

```bash
cleanup
```

That's it! The tool will:

- Clean Homebrew caches
- Clean npm/pnpm/Yarn caches
- Clean Python pip caches
- Clean RubyGems caches
- Clean VSCode caches
- Clean Docker unused resources
- Remove .DS_Store files
- Show a disk usage report

## Common Usage

### Safe Cleanup (Recommended for Regular Use)

```bash
# Normal cleanup with confirmation
cleanup --confirm

# Normal cleanup with disk report
cleanup --report
```

### Deep Cleanup (When You Need More Space)

```bash
# Preview deep cleanup first
cleanup --deep --dry-run

# Run deep cleanup (removes Docker images/volumes)
cleanup --deep --confirm
```

### Check Logs

```bash
# View latest log
ls -lt ~/.cleanup/logs/ | head -1

# Follow log in real-time
tail -f ~/.cleanup/logs/cleanup-*.log
```

## Configuration (Optional)

Create `~/.cleanup.conf` to customize defaults:

```bash
# Always ask for confirmation
CLEANUP_DEFAULT_CONFIRM=1

# Always show disk report
CLEANUP_DEFAULT_REPORT=1

# Enable logging (default)
CLEANUP_LOGGING=1
```

## Version Management (For Maintainers)

```bash
# Bump patch version (0.2.0 -> 0.2.1)
cleanup version patch

# Push the release
git push && git push --tags
```

## Update cleanup

### Via Homebrew

```bash
brew upgrade attara/cleanup/cleanup
```

### Via Git (if installed from clone)

```bash
cleanup --self-update
```

## Troubleshooting

### "Permission denied"

```bash
chmod +x cleanup
```

### "Command not found"

Make sure cleanup is in your PATH:

```bash
echo $PATH
which cleanup
```

Add to PATH in ~/.zshrc or ~/.bashrc:

```bash
export PATH="$HOME/bin:$PATH"
```

### "Docker cleanup fails"

Docker must be running:

```bash
# Start Docker Desktop
open -a Docker

# Or skip Docker cleanup
# (cleanup handles this gracefully)
```

## Next Steps

- Read the [full README](../README.md) for all features
- Check the [Contributing Guide](../CONTRIBUTING.md) to contribute
- See the [Homebrew Tap Setup Guide](HOMEBREW_TAP_SETUP.md) to set up your own tap
- Review the [macOS Notarization Guide](NOTARIZATION_SETUP.md) for distribution
- Browse all [documentation](README.md)

## Tips

1. **Run weekly**: Set up a cron job or calendar reminder

   ```bash
   # Add to crontab (run every Sunday at 2am)
   0 2 * * 0 /usr/local/bin/cleanup
   ```

2. **Check disk space before/after**:

   ```bash
   df -h ~
   cleanup
   df -h ~
   ```

3. **Use --dry-run before major cleanups**:

   ```bash
   cleanup --deep --dry-run
   ```

4. **Keep logs enabled** for troubleshooting:

   ```bash
   # Logs are in ~/.cleanup/logs/
   # Clean old logs manually if needed
   find ~/.cleanup/logs -mtime +30 -delete
   ```

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/attaradev/cleanup-tools/issues)
- **Discussions**: [GitHub Discussions](https://github.com/attaradev/cleanup-tools/discussions)
- **Documentation**: [README.md](../README.md)

Happy cleaning!
