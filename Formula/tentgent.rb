class Tentgent < Formula
  desc "Local AI runtime, dataset, server, daemon, and TUI toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.4.1/tentgent-0.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "52fb0eb96430b3ec9a53014b2d7f2919df2b0be0c8658fa7c8e58c925a6cb1d9"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v0.4.1/tentgent-0.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "55137b31dea3a75978fcde8d5e3fabb4a2826833853ba5c0d6b3f171ee4cd0b4"
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
