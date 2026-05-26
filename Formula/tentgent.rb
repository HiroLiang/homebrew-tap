class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.5.0/tentgent-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "e8cb42ae9853bc56271ff6f18b74ee63122b2bbd256fb241cbb198e5e0e68208"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.5.0/tentgent-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "a0b3e406a2e98a6886d5cddbf145914c5f5123a8f33d42bdf499688c59fa07b5"
    end
  end

  def install
    bin.install "bin/tentgent"
    pkgshare.install "share/tentgent/python"
    pkgshare.install "share/tentgent/scripts"
    doc.install "README.md"
    prefix.install "LICENSE"
  end

  def caveats
    <<~EOS
      Tentgent installs the CLI and packaged support files only.
      To prepare the managed Python runtime:

        tentgent runtime bootstrap

      Then verify:

        tentgent doctor

      Runtime data is stored under TENTGENT_HOME or the platform default.
      brew uninstall tentgent does not remove models, adapters, datasets,
      sessions, server records, logs, provider keys, or runtime caches.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tentgent --version")
  end
end
