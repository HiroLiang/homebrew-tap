class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v1.0.1/tentgent-1.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "a24013b1a6dcbf9af84478589ff1ec6040e6e377fb4be1b811217dae59e283e9"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v1.0.1/tentgent-1.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "65a4659bd675b4a3896f476088c35dbe1ef0c2d73c25c84e32833fdab6bfccfd"
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
