# Agent Guidelines for Dotfiles Repository

This document outlines the conventions, commands, and code style for AI agents operating within this dotfiles repository.

## 1. Repository Overview

This repository manages configuration files (dotfiles) for macOS/Linux environments, focusing on:
- **Neovim**: Custom setup (`nvim/`) and LazyVim-based setup (`nvim_lazyvim/`).
- **Shell**: Zsh configuration and setup scripts.
- **Utilities**: Python helper scripts (e.g., `ask_ai.py`).

## 2. Build, Install, and Test Commands

Since this is a configuration repository, "build" refers to the installation/symlinking process.

### Installation
To install or apply changes, use the provided script. Always verify the script contents before running.

```bash
# Installs dotfiles (creates symlinks and backups)
./install.sh
```

### Testing
There are no automated unit tests. Verification is manual:
- **Shell Changes**: `source ~/.zshrc` or restart the terminal.
- **Neovim Changes**: Open `nvim` and check for errors. Run `nvim +Lazy` to sync plugins.
- **Python Scripts**: Run manually: `python3 nvim/python/ask_ai.py "test question"`

### Linting & Formatting
- **Lua**: Use `stylua`.
  - Config: `nvim_lazyvim/stylua.toml` (2 spaces, 120 columns).
  - Command: `stylua nvim/ nvim_lazyvim/`
- **Shell**: Use `shellcheck` for static analysis.
- **Python**: Standard PEP 8, 4 spaces indentation.

## 3. Code Style Guidelines

### General Principles
- **Backups**: When modifying `install.sh` or core configs, ensure logic preserves existing files (e.g., `backup_and_link` function).
- **Paths**: Use `$HOME` or `~` relative paths in scripts; absolute paths in tool calls.
- **Emojis**: Use emojis in shell script output for readability (e.g., 🚀, ✅, ⚠️).

### Lua (Neovim)
- **Indentation**: **2 spaces**.
- **Formatting**: Adhere to `stylua.toml`.
- **Structure**:
  - `lua/config/`: Core settings (`options.lua`, `keymaps.lua`).
  - `lua/plugins/`: Plugin specs returning a table.
- **LazyVim**: Respect LazyVim structure. Do not overwrite core defaults unless necessary; use `vim.list_extend` or merge tables where appropriate.

```lua
-- Example Plugin Spec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "lua", "python", "bash" },
  },
}
```

### Shell (Bash/Zsh)
- **Shebang**: `#!/bin/bash` for scripts.
- **Indentation**: **2 spaces**.
- **Variables**: Uppercase for globals (`DOTFILES_DIR`), lowercase for locals.
- **Functions**: Use functions for repetitive tasks.
- **Safety**: Quote variables (`"$VAR"`) to handle spaces.

```bash
install_pkg() {
  local pkg="$1"
  echo "📦 Installing $pkg..."
  # ... implementation
}
```

### Python
- **Indentation**: **4 spaces**.
- **Language**: Comments in **Japanese** are acceptable/encouraged for this specific project (as seen in `ask_ai.py`).
- **Dependencies**: Check imports. Use standard library where possible to avoid `pip` dependencies for simple scripts.
- **Error Handling**: Use `try...except` blocks for external API calls or file I/O.

```python
import sys
import os

# 日本語のコメントもOK
def main():
    try:
        # logic
        pass
    except Exception as e:
        print(f"Error: {e}")
```

## 4. Workflow for Agents

1.  **Analysis**: Read `install.sh` and `nvim/init.lua` to understand the current state.
2.  **Modification**:
    - If adding a Neovim plugin, create a new file in `lua/plugins/` if it's substantial, or append to `lua/plugins/init.lua`.
    - If modifying shell aliases, check `.zshrc` or `setup/` scripts.
3.  **Verification**:
    - For shell scripts: strict syntax check.
    - For Lua: check for syntax errors.
4.  **Commit**: Write clear, English commit messages describing the *why*, not just the *what*.

## 5. File Locations
- **LazyVim Config**: `nvim_lazyvim/`
- **Custom Nvim**: `nvim/`
- **Shell Setup**: `setup/`
- **Install Entry Point**: `install.sh`
