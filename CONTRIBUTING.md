# Contributing to cleanup

Thank you for your interest in contributing to cleanup! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help maintain a positive community

## Getting Started

### Prerequisites

- macOS (the tool is macOS-specific)
- Bash 4.0 or later
- Git
- ShellCheck (for linting)

### Setting Up Development Environment

```bash
# Clone the repository
git clone https://github.com/attaradev/cleanup-tools.git
cd cleanup-tools

# Install ShellCheck
brew install shellcheck

# Make the script executable
chmod +x cleanup

# Test it works
./cleanup --version
./cleanup --dry-run
```

## Development Workflow

### 1. Create a Branch

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/bug-description
```

### 2. Make Your Changes

#### Code Style Guidelines

- Use 2 spaces for indentation (no tabs)
- Keep lines under 100 characters when possible
- Use meaningful variable names
- Add comments for complex logic
- Follow existing patterns in the codebase

#### Shell Script Best Practices

```bash
# Good: Use quotes around variables
rm -rf "$HOME/.cache/some-tool"

# Good: Check if command exists
if command -v npm >/dev/null 2>&1; then
  npm cache clean --force
fi

# Good: Handle errors gracefully
run_cmd brew cleanup || true

# Good: Use functions for repeated logic
delete_path() {
  local target="$1"
  if [ ! -e "$target" ]; then
    return 0
  fi
  # ...
}
```

### 3. Test Your Changes

#### Manual Testing

```bash
# Test syntax
bash -n cleanup

# Run ShellCheck
shellcheck cleanup

# Test dry-run mode
./cleanup --dry-run

# Test actual cleanup (careful!)
./cleanup --confirm

# Test new features
./cleanup version patch  # if you modified version management
```

#### Test Checklist

- [ ] Script passes ShellCheck with no errors
- [ ] Script passes bash syntax check (`bash -n cleanup`)
- [ ] `--version` flag works
- [ ] `--help` flag works
- [ ] `--dry-run` mode works
- [ ] Normal cleanup works without errors
- [ ] New functionality works as expected
- [ ] Doesn't break existing functionality

### 4. Document Your Changes

- Update README.md if adding new features
- Update CHANGELOG.md in the Unreleased section
- Add comments in code for complex logic
- Update help text if adding new options

### 5. Commit Your Changes

Use conventional commit messages:

```bash
# Features
git commit -m "feat: add support for pnpm cache cleanup"

# Bug fixes
git commit -m "fix: handle missing Docker gracefully"

# Documentation
git commit -m "docs: update installation instructions"

# Refactoring
git commit -m "refactor: improve error handling"

# Tests
git commit -m "test: add tests for version bumping"

# Chores
git commit -m "chore: update dependencies"
```

### 6. Push and Create Pull Request

```bash
# Push your branch
git push origin feature/your-feature-name

# Create a pull request on GitHub
# Go to: https://github.com/attaradev/cleanup-tools/pulls
```

## Pull Request Guidelines

### PR Description Template

```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Tested with `--dry-run`
- [ ] Tested actual cleanup
- [ ] ShellCheck passes
- [ ] No bash syntax errors

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review of my code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have updated the documentation accordingly
- [ ] My changes generate no new warnings
```

### Review Process

1. Maintainers will review your PR
2. Address any feedback or requested changes
3. Once approved, your PR will be merged
4. Your contribution will be included in the next release

## Types of Contributions

### Bug Reports

Use the GitHub issue tracker with:
- Clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- System information (macOS version, bash version)
- Relevant log files

### Feature Requests

Include:
- Clear description of the feature
- Use case / motivation
- Example of how it would work
- Potential implementation ideas (optional)

### Code Contributions

We welcome:
- Bug fixes
- New cleanup targets (new tools/caches)
- Performance improvements
- Better error handling
- Documentation improvements
- Test improvements

### Documentation

Help improve:
- README.md
- Setup guides (Homebrew, notarization)
- Code comments
- Usage examples
- Troubleshooting guides

## Adding New Cleanup Targets

If you want to add support for cleaning a new tool:

```bash
# 1. Add a section in the cleanup script
echo "🧹 Cleaning YourTool..."

# 2. Check if the tool exists
if command -v yourtool >/dev/null 2>&1; then
  # Tool is installed, clean it
  run_cmd yourtool cache clean || true
fi

# 3. Or clean a cache directory
delete_path "$HOME/.cache/yourtool"
delete_path "$HOME/Library/Caches/YourTool"

# 4. Update README.md with the new tool
# 5. Test with --dry-run first
# 6. Update CHANGELOG.md
```

## Testing Checklist for New Features

- [ ] Works on latest macOS
- [ ] Handles missing tools gracefully
- [ ] Respects `--dry-run` flag
- [ ] Logs operations when enabled
- [ ] Doesn't break existing functionality
- [ ] Includes helpful error messages
- [ ] Updates documentation

## Release Process

Maintainers will:
1. Review and merge PRs
2. Update CHANGELOG.md
3. Bump version: `./cleanup version [patch|minor|major]`
4. Push tags: `git push && git push --tags`
5. GitHub Actions creates the release automatically

## Questions?

- Open an issue for questions
- Tag with `question` label
- Check existing issues first

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors are recognized in:
- GitHub contributors page
- Release notes for their contributions
- CHANGELOG.md for significant features

Thank you for contributing to cleanup!
