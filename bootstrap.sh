#!/bin/bash
# ~/dotfiles/bootstrap.sh
# 新しい環境で最初に実行するスクリプト

set -e # エラーで停止

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
  echo "🍎 Running Mac setup..."
  bash "$SCRIPT_DIR/setup/mac.sh"
fi

# Linux用セットアップ
if [ "$OS" = "linux" ]; then
  echo "🐧 Running Linux setup..."
  bash "$SCRIPT_DIR/setup/linux.sh"
fi

# 共通セットアップ
echo "⚙️  Running common setup..."
bash "$SCRIPT_DIR/setup/common.sh"

# dotfiles リンク
echo "🔗 Linking dotfiles..."
bash "$SCRIPT_DIR/install.sh"

echo ""
echo "✅ Bootstrap complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Open nvim (plugins will auto-install)"
echo ""
