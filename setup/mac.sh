#!/bin/bash

# ~/dotfiles/setup/mac.sh

echo "🍎 Setting up Mac..."

confirm() {
  local prompt="$1"
  if [ "${DOTFILES_ASSUME_YES}" = "1" ]; then
    return 0
  fi
  read -r -p "$prompt [y/N]: " reply
  case "$reply" in
    [yY]|[yY][eE][sS]) return 0 ;;
    *) return 1 ;;
  esac
}

# Homebrew インストール（なければ）
if ! command -v brew &>/dev/null; then
  if confirm "Install Homebrew?"; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Homebrewをパスに追加
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "⏭️  Skipping Homebrew install."
  fi
else
  echo "✅ Homebrew already installed"
fi

# 基本ツール
if confirm "Install CLI tools via Homebrew?"; then
  echo "📦 Installing tools via Homebrew..."
  brew install \
    git \
    curl \
    wget \
    zsh \
    tmux \
    neovim \
    fzf \
    ripgrep \
    bat \
    eza \
    zoxide \
    starship \
    lazygit \
    gh \
    fd \
    jq \
    tree \
    ghq \
    glow \
    tlrc \
    fastfetch \
    sheldon \
    mise
else
  echo "⏭️  Skipping CLI tools install."
fi

# Cask（GUI アプリ）
if confirm "Install GUI apps via Homebrew Cask?"; then
  echo "📦 Installing GUI apps..."
  brew install --cask \
    alacritty \
    font-jetbrains-mono-nerd-font \
    ghostty
else
  echo "⏭️  Skipping GUI apps install."
fi

# 追加のオプショナルツール（.zshrcのエイリアスで使用）
if confirm "Install optional tools (lazydocker, yazi, pnpm, openjdk@21, libpq)?"; then
  echo "📦 Installing optional tools..."
  
  if confirm "  Install lazydocker (Docker TUI)?"; then
    brew install lazydocker
  fi
  
  if confirm "  Install yazi (file manager)?"; then
    brew install yazi
  fi
  
  if confirm "  Install pnpm (Node.js package manager)?"; then
    brew install pnpm
  fi
  
  if confirm "  Install openjdk@21 (Java)?"; then
    brew install openjdk@21
  fi
  
  if confirm "  Install libpq (PostgreSQL client)?"; then
    brew install libpq
  fi
  
  echo "✅ Optional tools installation complete!"
else
  echo "⏭️  Skipping optional tools install."
fi

echo "✅ Mac setup complete!"
