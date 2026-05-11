# Homebrew Tap For Tentgent

This is the project-owned Homebrew tap for
[Tentgent](https://github.com/HiroLiang/tentserv-agent).

## Install

```bash
brew tap hiroliang/tap
brew install tentgent
```

Verify the CLI:

```bash
tentgent --version
tentgent status
```

## Runtime Bootstrap

The Homebrew formula installs the Tentgent CLI and packaged support files only.
It does not download the managed Python runtime, download models, start daemon
processes, or mutate `TENTGENT_HOME` during `brew install`.

After installation, bootstrap the managed Python runtime:

```bash
tentgent runtime bootstrap
tentgent doctor
```

This bootstrap downloads a pinned `uv` executable into Tentgent-owned runtime
cache and syncs the managed Python environment. Users do not need to install
`uv` globally.

## Upgrade

```bash
brew update
brew upgrade tentgent
```

If a release changes Python dependencies, rerun the runtime bootstrap command
after upgrading.

## Uninstall

```bash
brew uninstall tentgent
```

Normal uninstall removes Homebrew-installed files only. It does not remove
Tentgent runtime data such as models, adapters, datasets, sessions, server
records, provider secrets, logs, managed Python environments, or bootstrap
caches.

To intentionally remove runtime data, inspect `tentgent status` first and delete
the relevant `TENTGENT_HOME` paths manually.

## Full Documentation

- [README](https://github.com/HiroLiang/tentserv-agent#readme)
- [Install Guide](https://github.com/HiroLiang/tentserv-agent/blob/main/docs/user/install.md)
- [CLI Commands](https://github.com/HiroLiang/tentserv-agent/blob/main/docs/user/commands.md)
- [Runtime Notes](https://github.com/HiroLiang/tentserv-agent/blob/main/docs/user/runtime.md)
