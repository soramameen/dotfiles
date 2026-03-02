#!/bin/bash

echo "🚀 Installing dotfiles..."

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

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

if ! confirm "Proceed with linking dotfiles to your home directory?"; then
  echo "❌ Aborted."
  exit 1
fi

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

# ghostty
if [ -d "$DOTFILES_DIR/ghostty" ]; then
  backup_and_link "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
fi

# opencode (individual files to preserve private data)
if [ -d "$DOTFILES_DIR/opencode" ]; then
  # Create .config/opencode if it doesn't exist
  mkdir -p "$HOME/.config/opencode"

  # Link individual files/directories (not entire directory to preserve private data)
  if [ -f "$DOTFILES_DIR/opencode/opencode.json" ]; then
    backup_and_link "$DOTFILES_DIR/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"
  fi

  if [ -f "$DOTFILES_DIR/opencode/oh-my-opencode.json" ]; then
    backup_and_link "$DOTFILES_DIR/opencode/oh-my-opencode.json" "$HOME/.config/opencode/oh-my-opencode.json"
  fi

  if [ -d "$DOTFILES_DIR/opencode/skills" ]; then
    backup_and_link "$DOTFILES_DIR/opencode/skills" "$HOME/.config/opencode/skills"
  fi

  if [ -d "$DOTFILES_DIR/opencode/agent" ]; then
    backup_and_link "$DOTFILES_DIR/opencode/agent" "$HOME/.config/opencode/agent"
  fi
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
