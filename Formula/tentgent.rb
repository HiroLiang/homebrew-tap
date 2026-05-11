class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.3.2/tentgent-0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "1d36e044a138feed3fd59ea15cb64d44801bf3acc366b258fca6c5ffc5cf9f65"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.3.2/tentgent-0.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "3aed8093c0c0da03dcfcfb1d4410cd4ad9152b75eb9b1a6128d4bf31a41dea4b"
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
