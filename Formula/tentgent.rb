class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.8.0/tentgent-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "3c23d5d047e2a472ccd1f097f9e193ac366cb4a1a0eea3f35d77759a7609f8e1"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.8.0/tentgent-0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "7cc9c7c4a3f3e96be638bac77ca6c6d9aa7e772632da0548846db7333c43b6ad"
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
