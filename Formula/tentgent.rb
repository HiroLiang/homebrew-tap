class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.5.2/tentgent-0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "ea208ab084936dd26fb1b3c5912f2d199dd8c17526138c4b84e3178bb7e424ff"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.5.2/tentgent-0.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "a1391ef81f67922432971d61b10f250d61179f5b46db4e6f75381a5f82cdb889"
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
