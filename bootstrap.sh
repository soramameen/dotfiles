#!/bin/bash
# ~/dotfiles/bootstrap.sh
# 新しい環境で最初に実行するスクリプト

set -e # エラーで停止

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

echo "🚀 Starting dotfiles bootstrap..."

# スクリプトのディレクトリ
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export DOTFILES_DIR="$SCRIPT_DIR"

# OS判定
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS="mac"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"
else
  echo "❌ Unsupported OS: $OSTYPE"
  exit 1
fi

echo "📱 Detected OS: $OS"

# Mac用セットアップ
if [ "$OS" = "mac" ]; then
  if confirm "Run Mac setup (installs packages/apps)?"; then
    echo "🍎 Running Mac setup..."
    DOTFILES_ASSUME_YES=1 bash "$SCRIPT_DIR/setup/mac.sh"
  else
    echo "⏭️  Skipping Mac setup."
  fi
fi

# Linux用セットアップ
if [ "$OS" = "linux" ]; then
  if confirm "Run Linux setup (installs packages)?"; then
    echo "🐧 Running Linux setup..."
    DOTFILES_ASSUME_YES=1 bash "$SCRIPT_DIR/setup/linux.sh"
  else
    echo "⏭️  Skipping Linux setup."
  fi
fi

# 共通セットアップ
if confirm "Run common setup (shell/git settings)?"; then
  echo "⚙️  Running common setup..."
  DOTFILES_ASSUME_YES=1 bash "$SCRIPT_DIR/setup/common.sh"
else
  echo "⏭️  Skipping common setup."
fi

# dotfiles リンク
if confirm "Link dotfiles (backs up and overwrites configs)?"; then
  echo "🔗 Linking dotfiles..."
  DOTFILES_ASSUME_YES=1 bash "$SCRIPT_DIR/install.sh"
else
  echo "⏭️  Skipping dotfiles linking."
fi

echo ""
echo "✅ Bootstrap complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Open nvim (plugins will auto-install)"
echo ""
