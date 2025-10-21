#!/bin/bash

# ~/dotfiles/setup/common.sh

echo "⚙️  Running common setup..."

# zsh をデフォルトシェルに
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🐚 Setting zsh as default shell..."
  chsh -s $(which zsh)
  echo "✅ Default shell changed to zsh"
  echo "⚠️  Please log out and log back in for shell change to take effect"
else
  echo "✅ zsh is already the default shell"
fi

# ~/.local/bin を作成（ユーザーローカルのバイナリ用）
mkdir -p "$HOME/.local/bin"

# Git 基本設定（ユーザー情報は .gitconfig.local で）
echo "📝 Setting up Git..."
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor nvim

echo "✅ Common setup complete!"
