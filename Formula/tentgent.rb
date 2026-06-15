class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.7.0/tentgent-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "c542e275e59720604590b422210b0a05e83fbac8382f2c83b7c70f9e4e6d30b0"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.7.0/tentgent-0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "03396404604612317bacd4550210e2a15a935c507d9ccebe2274c90c5e983e23"
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
