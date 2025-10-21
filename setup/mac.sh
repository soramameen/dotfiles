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
  gh

# Cask（GUI アプリ）
echo "📦 Installing GUI apps..."
brew install --cask \
  alacritty \
  font-jetbrains-mono-nerd-font

echo "✅ Mac setup complete!"
