class Tentgent < Formula
  desc "Local AI runtime, model server, daemon, and cluster routing toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v1.1.1/tentgent-1.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "5a6170bdc21ee753c0d9ed6c322752c60135d1135e08f8bb09484716f6205046"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v1.1.1/tentgent-1.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "93f47fe417cbbb1b86bc47c65f590d624db6ad252787dafbf5915c116c6b7354"
    end
  end

  def install
    bin.install "bin/tentgent"
    pkgshare.install "share/tentgent/pyproject.toml"
    pkgshare.install "share/tentgent/uv.lock"
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
