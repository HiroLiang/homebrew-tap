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

Homebrew updates the CLI and packaged source; the managed Python environment
must also be refreshed when runtime code or dependencies change. Stop affected
workloads, rerun bootstrap with the same profile, and restart them. For local
models:

```bash
tentgent runtime bootstrap --profile local-model
```

The replacement `1.1.2_1` Homebrew package fixes GGUF model selection when the
source also contains a projector. The CLI version remains `1.1.2`; `brew list
--versions tentgent` shows the package revision. Existing model downloads can
be reused.

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
