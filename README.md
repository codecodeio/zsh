# zsh

My personal zsh shell configuration, version-controlled so I can sync it across machines.

## Purpose

This repo lives at `$HOME` and uses an allowlist `.gitignore` so that only the shell config files are tracked — everything else in the home directory is ignored. Clone it onto a new Mac and your prompt, aliases, and shell functions come with you.

Tracked files:

- **`.zshrc`** — interactive shell config: prompt, aliases, and helper functions (git shortcuts, image conversion, Docker, navigation, etc.).
- **`.zprofile`** — login-shell `PATH` setup (Homebrew, pnpm, `~/.local/bin`).
- **`.gitignore`** — allowlist that keeps the rest of `$HOME` out of git.
- **`README.md`** — this file.

## Setting up a new machine

```bash
cd ~
git init
git remote add origin git@github.com:codecodeio/zsh.git
git pull origin main
source ~/.zshrc
```

Because of the allowlist `.gitignore`, the pull will only land the four tracked files — nothing else in your home directory is touched.

## Day-to-day use

After editing `.zshrc` or `.zprofile`, reload with:

```bash
refresh        # alias defined in .zshrc; re-sources both files
```

Commit and push from `$HOME` like any other repo:

```bash
cd ~
git status
git add .zshrc
commit "your message"   # `commit` is an alias for `git commit -m`
push
```

## Machine-local overrides

`.zshrc` sources `~/.zshrcwork` at the end if it exists. That file is intentionally **not tracked** — use it for work-specific aliases, secrets, or anything that shouldn't be shared across machines.

## Requirements

macOS with Homebrew. Some functions shell out to optional tools (`cwebp`, `rsvg-convert`, Visual Studio Code's `code` CLI, Docker) — install only what you use.
