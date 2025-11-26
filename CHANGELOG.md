# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2025-11-26

### Added

- Docker daemon responsiveness check with 5-second timeout to prevent hanging
- Improved disk usage report with better visual formatting
- Top 20 largest directories display with aligned columns

### Changed

- Limited `.DS_Store` cleanup to specific directories (Documents, Desktop, Downloads, Projects, src, dev) for faster execution
- Enhanced report UX with decorative separators and cleaner layout
- Docker cleanup now skips gracefully when daemon is not responding

### Fixed

- Script no longer hangs when Docker daemon is unresponsive
- `.DS_Store` cleanup is significantly faster by avoiding full home directory scan

## [0.2.0] - 2025-01-26

### New

- Initial cleanup tool release
- Support for multiple dev tools: Homebrew, npm, pnpm, Yarn, pip, RubyGems, VSCode, Docker
- Dry-run mode for previewing changes
- Deep cleanup mode for Docker
- Configurable options via `~/.cleanup.conf`
- Automatic logging to `~/.cleanup/logs/`
- Self-update functionality via git
- Disk usage reporting

### Features

- Safe cache and temporary file cleanup
- Multiple command-line options (--dry-run, --confirm, --deep, --report)
- Comprehensive logging with timestamps
- Graceful handling of missing tools

## [0.1.0] - Initial Development

### Initial Features

- Basic script structure
- Core cleanup functionality
- Command-line argument parsing

---

## Release Process

1. Update version: `./cleanup version [patch|minor|major]`
2. Update CHANGELOG.md with release notes
3. Commit changes: `git commit -am "chore: prepare release vX.Y.Z"`
4. Push with tags: `git push && git push --tags`
5. GitHub Actions will create the release automatically

## Version Numbering

- **MAJOR** (X.0.0): Breaking changes, major features
- **MINOR** (0.X.0): New features, backwards compatible
- **PATCH** (0.0.X): Bug fixes, minor improvements
