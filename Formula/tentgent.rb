class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.9.0/tentgent-0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "156be9649c20b756d4935b6ea2cb59b5652cc4fdaf71a09370887139506afecb"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.9.0/tentgent-0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "910c98e84d6ccefff64f1674355853ace21f3ddba4ca293095e40dec22d775a7"
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
