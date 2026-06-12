# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This repo is the user's `$HOME` directory tracked as a git repo (`git@github.com:codecodeio/zsh.git`) for syncing zsh shell configuration across machines. The `.gitignore` uses an allowlist pattern — `*` is ignored, only `.zshrc`, `.zprofile`, `.gitignore`, and `README.md` are tracked. **Do not add new tracked files** unless you also add a matching `!` allowlist entry to `.gitignore`; otherwise the file will be silently ignored.

## Reloading after edits

There is no build or test step. After editing `.zshrc` or `.zprofile`, reload with:

```
source ~/.zshrc       # or use the `refresh` alias defined in .zshrc
```

The `refresh` alias sources both files. Changes to `.zprofile` only take effect on a new login shell or after explicit re-sourcing — `refresh` handles this.

## Structure of the two tracked shell files

- `.zprofile` — runs once at login. Used for `PATH` setup and one-time env (`brew shellenv`, `PNPM_HOME`, `~/.local/bin`). Add things here that should be in the environment of all spawned shells, not re-evaluated per interactive shell.
- `.zshrc` — runs for every interactive shell. Contains the prompt config, all aliases, and all shell functions. Organized by section comment headers (`#Git`, `#Terminal`, `#DOCKER`, etc.) — preserve that grouping when adding new entries.

## Conventions used in `.zshrc`

- **Aliases vs functions:** simple one-liners use `alias`; anything that takes arguments or has logic uses a function. Follow the existing pattern when adding to a section.
- **Emoji feedback:** user-facing function output uses ✅ / ❌ / 🌐 / 🚫 prefixes (see `del`, `commit`, `openrepo`). Match this style for new interactive functions.
- **`$USER` paths:** functions that reference the home dir use `/Users/$USER/...` rather than `~` or `$HOME` so the same file works across machines with different usernames. `USER` is set explicitly near the top of `.zshrc` via `USER=${"$(id -un)"}`.
- **macOS-only assumptions:** uses `open -a`, `sips`, `mdfind`, `pbcopy`-style tools, and Homebrew paths (`/opt/homebrew/bin/brew`). This config is not portable to Linux without changes.
- **External tool dependencies** referenced by functions: `cwebp` (`towebp`), `rsvg-convert` (`tosvg`), `sips` (built-in, used by `pngopt`), Visual Studio Code CLI (`code`), Docker. If adding a function that shells out, assume Homebrew is available.

## Branch sync (`_` and `main`)

`_` is just a short working-branch name the user types instead of `main`. **`_` and `main` must always point at the same commit** — they are kept perfectly in sync, in both directions.

Every time you commit and push, do all of the following so neither branch is left behind:

1. Commit on the current branch (usually `_`).
2. Fast-forward the other branch to match (`_` → `main`, or `main` → `_`), e.g. `git fetch . <src>:<dst>` for the non-checked-out branch, or merge `--ff-only`.
3. Push **both** branches: `git push origin _ main`.
4. Verify both match their remotes with `git rev-list --left-right --count _...origin/_` and the same for `main` (both should read `0	0`).

If the branches ever diverge, reconcile them back to a single shared commit before pushing — do not push one without the other.

## Common gotchas

- The git workflow is unusual: `cd ~ && git status` operates on the home directory. Be careful — `git add -A` would do nothing dangerous because of the allowlist `.gitignore`, but always confirm `git status` output before committing.
- Several aliases shadow common commands (`status`, `add`, `commit`, `push`, `pull`, `branch`, `merge`, `tag`, `config`, `clone`, `fetch`, `stash`, `checkout` are all git aliases). When running shell commands in this repo, prefer explicit `git <subcommand>` to avoid confusion about whether you're invoking the alias or the binary.
