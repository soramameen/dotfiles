#!/bin/bash

echo "🚀 Installing dotfiles..."

# dotfilesディレクトリのパス
DOTFILES_DIR="$HOME/dotfiles"

# バックアップディレクトリ作成
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# 既存ファイルのバックアップとシンボリックリンク作成
backup_and_link() {
  local source="$1"
  local target="$2"

  # 既存ファイル/ディレクトリがあればバックアップ
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "📦 Backing up $target"
    mv "$target" "$BACKUP_DIR/"
  fi

  # シンボリックリンク作成
  echo "🔗 Linking $source -> $target"
  ln -sf "$source" "$target"
}

# .zshrc
backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# .configディレクトリ作成
mkdir -p "$HOME/.config"

# Neovim
backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
# alacritty
if [ -d "$DOTFILES_DIR/alacritty" ]; then
  backup_and_link "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"
fi
# tmux
if [ -f "$DOTFILES_DIR/.tmux.conf" ]; then
  backup_and_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
fi

# .gitconfig
backup_and_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

echo "✅ Dotfiles installed!"
echo "📦 Backups saved to: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open nvim to sync plugins: nvim +Lazy"
