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
    fastfetch
else
  echo "⏭️  Skipping CLI tools install."
fi

# Cask（GUI アプリ）
if confirm "Install GUI apps via Homebrew Cask?"; then
  echo "📦 Installing GUI apps..."
  brew install --cask \
    alacritty \
    font-jetbrains-mono-nerd-font
else
  echo "⏭️  Skipping GUI apps install."
fi

# オプション: 会社のPCで必要に応じてアンコメント
# echo "📦 Installing optional tools..."
# brew install git-delta direnv mise nodenv rbenv
# brew install --cask ghostty visual-studio-code

echo "✅ Mac setup complete!"
