class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.5.1/tentgent-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "8fb7aa705164c80c6c1b073294e5d687f37b2b63c8b12b86a90549d32a3c384e"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.5.1/tentgent-0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "918e12c60bad63209af0ee4f9d767711cdfbf8e53864e73ddfe76516e264e782"
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
