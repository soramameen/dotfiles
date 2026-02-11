#!/bin/bash

# ~/dotfiles/setup/mac.sh

echo "🍎 Setting up Mac..."

# Homebrew インストール（なければ）
if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Homebrewをパスに追加
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed"
fi

# 基本ツール
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

# Cask（GUI アプリ）
echo "📦 Installing GUI apps..."
brew install --cask \
  alacritty \
  font-jetbrains-mono-nerd-font

# オプション: 会社のPCで必要に応じてアンコメント
# echo "📦 Installing optional tools..."
# brew install git-delta direnv mise nodenv rbenv
# brew install --cask ghostty visual-studio-code

echo "✅ Mac setup complete!"
