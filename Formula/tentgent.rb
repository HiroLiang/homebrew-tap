class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.3.3/tentgent-0.3.3-aarch64-apple-darwin.tar.gz"
      sha256 "f9eb001c87656ae2d4f70391c8a0e39223919f587a811fabee7c9a0005895b85"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.3.3/tentgent-0.3.3-x86_64-apple-darwin.tar.gz"
      sha256 "9a05c88b1a1587c52c36438a02d3aa6f1a93b437829d2f802b4beaf51aebe743"
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
