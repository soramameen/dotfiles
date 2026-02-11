#!/bin/bash

# ~/dotfiles/setup/common.sh

echo "⚙️  Running common setup..."

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

# zsh をデフォルトシェルに
if [ "$SHELL" != "$(which zsh)" ]; then
  if confirm "Set zsh as the default shell?"; then
    echo "🐚 Setting zsh as default shell..."
    chsh -s $(which zsh)
    echo "✅ Default shell changed to zsh"
    echo "⚠️  Please log out and log back in for shell change to take effect"
  else
    echo "⏭️  Skipping default shell change."
  fi
else
  echo "✅ zsh is already the default shell"
fi

# ~/.local/bin を作成（ユーザーローカルのバイナリ用）
mkdir -p "$HOME/.local/bin"

# Git 基本設定（ユーザー情報は .gitconfig.local で）
if confirm "Apply global git settings (default branch/editor)?"; then
  echo "📝 Setting up Git..."
  git config --global init.defaultBranch main
  git config --global pull.rebase false
  git config --global core.editor nvim
else
  echo "⏭️  Skipping global git settings."
fi

echo "✅ Common setup complete!"
