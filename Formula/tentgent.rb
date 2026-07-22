class Tentgent < Formula
  desc "Local AI runtime, model server, daemon, and cluster routing toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v1.1.0/tentgent-1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "53fe85ab26e59757080ef44f69004466667f9ecd14dd61288a0e89b880739947"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v1.1.0/tentgent-1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "a4d08b0b4092936f409727fad586137b6f2d607757e7f1daee45ce050ebe8e7d"
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
