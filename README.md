# cleanup

A powerful macOS development machine cleanup helper that safely removes caches, temporary files, and unused resources to free up disk space.

[![CI](https://github.com/attaradev/cleanup-tools/actions/workflows/ci.yml/badge.svg)](https://github.com/attaradev/cleanup-tools/actions/workflows/ci.yml)
[![Release](https://github.com/attaradev/cleanup-tools/actions/workflows/release.yml/badge.svg)](https://github.com/attaradev/cleanup-tools/actions/workflows/release.yml)

## Features

- **Safe Cleanup**: Removes only caches and temporary files, never your code or data
- **Multiple Tools**: Supports Homebrew, npm, pnpm, Yarn, pip, RubyGems, VSCode, Docker, and more
- **Dry-Run Mode**: Preview what would be cleaned before making changes
- **Deep Cleaning**: Optional aggressive cleanup for Docker volumes and images
- **Logging**: Automatic logging of all cleanup operations
- **Configurable**: Customize behavior via config file
- **Version Management**: Built-in semantic versioning support
- **Auto-Update**: Self-update from git repository

## Installation

### Homebrew (Recommended)

```bash
brew tap attara/cleanup
brew install attara/cleanup/cleanup
```

### Quick Install Script

```bash
curl -L https://github.com/attaradev/cleanup-tools/releases/latest/download/cleanup-*-macos.tar.gz | tar xz
sudo mv cleanup /usr/local/bin/
sudo chmod +x /usr/local/bin/cleanup
```

### Other Installation Methods

See the [Quick Start Guide](docs/QUICK_START.md) for detailed installation instructions including manual installation and cloning from source.

## Usage

### Basic Commands

```bash
# Run normal cleanup
cleanup

# Preview what would be cleaned (recommended first run)
cleanup --dry-run

# Ask for confirmation before running
cleanup --confirm

# Run deeper cleanup (includes Docker volumes/images)
cleanup --deep

# Show disk usage report after cleanup
cleanup --report

# Show version
cleanup --version

# Show help
cleanup --help

# Update from git repository
cleanup --self-update
```

## What Gets Cleaned

### Always Cleaned (Safe)

- **Homebrew**: Old formulas and cached downloads (`brew cleanup`)
- **npm**: Package cache (`~/.npm`)
- **pnpm**: Package cache (`~/Library/Caches/pnpm`)
- **Yarn**: Package cache (`~/Library/Caches/Yarn`)
- **pip**: Python package cache (`~/Library/Caches/pip`)
- **RubyGems**: Gem cache directories
- **VSCode**: Cache, CachedData, CachedExtensionVSIXs
- **Docker**: Unused containers, networks, and dangling images
- **ZSH**: Old completion dump files (`.zcompdump-*`)
- **System**: `.DS_Store` files, empty JCEF logs

### Deep Cleanup (--deep flag)

- **Docker**: ALL unused images and volumes (⚠️ use with caution)

## Configuration

Create a configuration file at `~/.cleanup.conf`:

```bash
# Default options
CLEANUP_DEFAULT_CONFIRM=0    # Ask for confirmation (0=no, 1=yes)
CLEANUP_DEFAULT_DEEP=0       # Run deep cleanup (0=no, 1=yes)
CLEANUP_DEFAULT_REPORT=1     # Show disk report (0=no, 1=yes)

# Logging
CLEANUP_LOGGING=1            # Enable logging (0=no, 1=yes)
CLEANUP_LOG_DIR="$HOME/.cleanup/logs"  # Log directory

# Custom config file location
CLEANUP_CONFIG_FILE="$HOME/.cleanup.conf"
```

## Logs

Cleanup logs are stored in `~/.cleanup/logs/` with timestamps:

```text
~/.cleanup/logs/cleanup-20250126-143022.log
```

View recent logs:

```bash
ls -la ~/.cleanup/logs/
tail -f ~/.cleanup/logs/cleanup-*.log
```

## Development & Contributing

Contributions are welcome! See the [Contributing Guide](CONTRIBUTING.md) for:

- Development setup
- Coding guidelines
- Testing procedures
- Pull request process

### Quick Development Setup

```bash
# Install ShellCheck
brew install shellcheck

# Run linting
shellcheck cleanup

# Test dry-run mode
./cleanup --dry-run
```

### For Maintainers

- **Creating Releases**: See [Contributing Guide](CONTRIBUTING.md#release-process)
- **Homebrew Tap Setup**: See [Homebrew Tap Setup Guide](docs/HOMEBREW_TAP_SETUP.md)
- **Code Signing**: See [macOS Notarization Guide](docs/NOTARIZATION_SETUP.md)

## Safety

This tool is designed to be safe:

- Only removes caches and temporary files
- Never touches your code, documents, or personal files
- Includes dry-run mode to preview changes
- Logs all operations for audit trail
- Skips operations if tools aren't installed

## Documentation

- [Quick Start Guide](docs/QUICK_START.md) - Get started in 5 minutes
- [Contributing Guide](CONTRIBUTING.md) - How to contribute
- [Homebrew Tap Setup](docs/HOMEBREW_TAP_SETUP.md) - Set up your own tap
- [macOS Notarization](docs/NOTARIZATION_SETUP.md) - Code signing setup
- [Changelog](CHANGELOG.md) - Version history

## License

MIT License - see LICENSE file for details

## Author

Created by [Mike Attara](https://github.com/attaradev)

## Support

- **Issues**: [GitHub Issues](https://github.com/attaradev/cleanup-tools/issues)
- **Discussions**: [GitHub Discussions](https://github.com/attaradev/cleanup-tools/discussions)
- **Releases**: [GitHub Releases](https://github.com/attaradev/cleanup-tools/releases)

---

**Note**: Always review what will be cleaned with `--dry-run` before running cleanup on a new system.
