class Cleanup < Formula
  desc "macOS dev-machine cleanup helper"
  homepage "https://github.com/attaradev/cleanup-tools"
  url "https://github.com/attaradev/cleanup-tools/releases/download/v0.2.0/cleanup-0.2.0-macos.tar.gz"
  sha256 "" # Will be updated by CI
  version "0.2.0"
  license "MIT"

  def install
    bin.install "cleanup"
  end

  def caveats
    <<~EOS
      cleanup is a macOS dev-machine cleanup helper.

      Basic usage:
        cleanup              # Run normal cleanup
        cleanup --dry-run    # Preview what would be cleaned
        cleanup --deep       # More aggressive cleanup (includes Docker)
        cleanup --help       # Show all options

      Version management:
        cleanup version patch   # Bump patch version
        cleanup version minor   # Bump minor version
        cleanup version major   # Bump major version

      For more information: https://github.com/attaradev/cleanup-tools
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cleanup --version")
    system "#{bin}/cleanup", "--dry-run"
  end
end
