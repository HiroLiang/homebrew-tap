class Tentgent < Formula
  desc "Local AI runtime, model server, daemon, and cluster routing toolkit"
  homepage "https://github.com/HiroLiang/tentserv-agent"
  license "Apache-2.0"
  revision 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v1.1.2/tentgent-1.1.2-aarch64-apple-darwin.tar.gz?revision=1"
      sha256 "0704b9e9192a3f4eff057a281087c2e9571df1b50681e25fb6e9d15457043b51"
    else
      url "https://github.com/HiroLiang/tentserv-agent/releases/download/v1.1.2/tentgent-1.1.2-x86_64-apple-darwin.tar.gz?revision=1"
      sha256 "0f25a865e682009dc7a754afb7f615c338b16ae42868201ab087d6155e4d7554"
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

      For local models, include the backend dependencies:

        tentgent runtime bootstrap --profile local-model

      After upgrading, stop affected workloads, repeat bootstrap with your
      existing profile, and restart them to load the updated Python runtime.

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
