class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.3.1/tentgent-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "a142a2902cde788bddca77a9b30021b2f786332b02d6c241e0581ac9b5bbf7b4"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.3.1/tentgent-0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "984ab569c93b8f1e4fd398a4c039888c78ff3ed5301449726e076e1dee6f6ab8"
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

        #{pkgshare}/scripts/bootstrap-python-env.sh --project #{pkgshare}/python

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
