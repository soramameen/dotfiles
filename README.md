# My Dotfiles

## 環境

- **OS**: macOS
- **Shell**: zsh
- **Editor**: Neovim + LazyVim
- **Terminal**: Alacritty 
- **Window Manager**: Magnet

## 構成
```
dotfiles/
├── .zshrc              # zsh設定
├── .gitconfig          # Git設定
├── .tmux.conf          # tmux設定
├── nvim/               # Neovim設定
│   ├── init.lua
│   └── lua/
│       ├── config/
│       └── plugins/
├── install.sh          # セットアップスクリプト
└── README.md
```

## インストール
```bash
# リポジトリをクローン
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# セットアップ実行
cd ~/dotfiles
./install.sh

# ターミナル再起動 or
source ~/.zshrc

# Neovim起動してプラグイン同期
nvim
```

## カスタム設定

### Neovim

- `jj` で Insert mode → Normal mode
- `Ctrl+n` でファイルツリー表示
- Gruvbox テーマ
- GitHub Copilot統合

### キーボードショートカット
```
Space + f + f  → ファイル検索
Space + g + g  → lazygit
Space + ,      → バッファ切り替え
Ctrl+n         → ファイルツリー
jj             → Esc
```

## 必要なツール
```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 基本ツール
brew install neovim tmux fzf ripgrep lazygit

# ターミナル
brew install --cask alacritty

# フォント
brew install --cask font-jetbrains-mono-nerd-font
```

## 参考

- [LazyVim](https://www.lazyvim.org/)
- [DHH's Omakub](https://omakub.org/)
- [thoughtbot dotfiles](https://github.com/thoughtbot/dotfiles)

---
