<div align="center">
  <img src="assets/logo.svg" alt="cleanup logo" width="200" />
</div>

# cleanup

A powerful macOS development machine cleanup helper that safely removes caches, temporary files, and unused resources to free up disk space.

[![CI](https://github.com/attaradev/cleanup-tools/actions/workflows/ci.yml/badge.svg)](https://github.com/attaradev/cleanup-tools/actions/workflows/ci.yml)
[![Release](https://github.com/attaradev/cleanup-tools/actions/workflows/release.yml/badge.svg)](https://github.com/attaradev/cleanup-tools/actions/workflows/release.yml)

## Features

- **Safe Cleanup**: Removes only caches and temporary files, never your code or data
- **20+ Development Tools**: Supports Homebrew, npm, Docker, Cargo, Go, Gradle, Maven, Xcode, JetBrains IDEs, and more
- **Size Estimation**: Preview cleanup with accurate size calculations before deletion
- **Selective Cleanup**: Clean only specific tools or skip tools with `--only` and `--skip` flags
- **Dry-Run Mode**: Preview what would be cleaned before making changes
- **Deep Cleaning**: Optional aggressive cleanup for Docker volumes and images
- **Safety Features**: Move files to trash instead of permanent deletion, warnings for large operations
- **Short & Long Params**: Use `-n` or `--dry-run`, `-o` or `--only`, etc.
- **Logging**: Automatic logging of all cleanup operations
- **Configurable**: Customize behavior via config file
- **Zero Dependencies**: Pure bash, works on any macOS system
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

Run normal cleanup:

```bash
cleanup
```

Preview what would be cleaned with size estimates (recommended first run):

```bash
cleanup -n              # or cleanup --dry-run
```

List all available cleanup targets:

```bash
cleanup -t              # or cleanup --tools
```

Clean only specific tools:

```bash
cleanup -o=docker,npm   # or cleanup --only=docker,npm
```

Skip specific tools:

```bash
cleanup -s=xcode -r     # or cleanup --skip=xcode --report
```

Ask for confirmation before running:

```bash
cleanup -c              # or cleanup --confirm
```

Run deeper cleanup (includes Docker volumes/images):

```bash
cleanup -d              # or cleanup --deep
```

Show disk usage report after cleanup:

```bash
cleanup -r              # or cleanup --report
```

Safe cleanup with trash instead of permanent deletion:

```bash
cleanup -T -c           # or cleanup --use-trash --confirm
```

Show version:

```bash
cleanup -v              # or cleanup --version
```

Show help:

```bash
cleanup -h              # or cleanup --help
```

Update from git repository:

```bash
cleanup -u              # or cleanup --self-update
```

## What Gets Cleaned

### 20+ Development Tools Supported

| Tool | What Gets Cleaned | Safe? |
|------|-------------------|-------|
| **homebrew** | Homebrew package cache | ✅ Yes |
| **npm** | npm package cache (`~/.npm`) | ✅ Yes |
| **pnpm** | pnpm package cache | ✅ Yes |
| **yarn** | Yarn package cache | ✅ Yes |
| **pip** | Python pip cache | ✅ Yes |
| **rubygems** | RubyGems cache directories | ✅ Yes |
| **cargo** | Rust Cargo registry cache | ✅ Yes |
| **go** | Go build cache | ✅ Yes |
| **gradle** | Gradle build cache | ✅ Yes |
| **maven** | Maven repository cache | ✅ Yes |
| **composer** | PHP Composer cache | ✅ Yes |
| **cocoapods** | CocoaPods cache | ✅ Yes |
| **xcode** | Xcode DerivedData & Archives | ✅ Yes |
| **android** | Android build cache | ✅ Yes |
| **jetbrains** | JetBrains IDEs cache | ✅ Yes |
| **vscode** | VSCode cache & extensions | ✅ Yes |
| **docker** | Unused containers/images | ✅ Yes |
| **zsh** | ZSH completion dumps | ✅ Yes |
| **jcef** | Empty JCEF log files | ✅ Yes |
| **dsstore** | .DS_Store files | ✅ Yes |

Use `cleanup -t` to see the full list with descriptions.

### Selective Cleanup Examples

```bash
# Clean only Docker and npm
cleanup -o=docker,npm

# Clean everything except Xcode and JetBrains
cleanup -s=xcode,jetbrains

# Preview what specific tools would clean
cleanup -n -o=cargo,go,gradle
```

### Deep Cleanup (-d flag)

- **Docker**: ALL unused images and volumes (⚠️ use with caution)

## Configuration

Create a configuration file at `~/.cleanup.conf`:

```bash
# Default options
CLEANUP_DEFAULT_CONFIRM=0    # Ask for confirmation (0=no, 1=yes)
CLEANUP_DEFAULT_DEEP=0       # Run deep cleanup (0=no, 1=yes)
CLEANUP_DEFAULT_REPORT=1     # Show disk report (0=no, 1=yes)
CLEANUP_USE_TRASH=0          # Use trash instead of rm (0=no, 1=yes)

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
