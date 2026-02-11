# Dotfiles

macOS / Linux 向けの dotfiles。

## セットアップ
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

リンクだけ貼り直したい場合:
```bash
./install.sh
```

## 構成
- bootstrap.sh: 入口（OS判定 → setup/ → install.sh）
- install.sh: dotfiles のリンク作成（バックアップ付き）
- setup/: mac.sh / linux.sh / common.sh
- .zshrc / .gitconfig / .tmux.conf
- nvim/: Neovim（LazyVim）設定
- ghostty/: Ghostty 設定
- opencode/: OpenCode 設定
