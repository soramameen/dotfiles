# OpenCode Configuration Setup

このディレクトリは `~/.config/opencode` にシンボリックリンクを貼って使用します。

## 1. シンボリックリンクの作成

dotfiles リポジトリを clone した後、以下のコマンドでシンボリックリンクを作成してください。

```bash
# 既存のディレクトリがないことを確認（ある場合はバックアップして削除）
rm -rf ~/.config/opencode

# シンボリックリンクの作成
ln -s ~/dotfiles/config/opencode ~/.config/opencode
```

## 2. 設定ファイルの復元 (Secrets)

機密情報は Git 管理外のため、テンプレートから実ファイルを作成し、APIキーを設定してください。

```bash
cd ~/.config/opencode

# メイン設定ファイルの復元
cp opencode.example.json opencode.json
# エディタで開き、"BRAVE_API_KEY" などを入力
# vim opencode.json

# oh-my-opencode設定の復元（必要な場合）
if [ -f oh-my-opencode.example.json ]; then
  cp oh-my-opencode.example.json oh-my-opencode.json
  # エディタで開き、必要なキーを入力
fi
```

## 3. 依存パッケージのインストール

`command/` ディレクトリ内のスクリプトやMCPサーバーに必要な依存関係をインストールします。

```bash
cd ~/.config/opencode
npm install
# または
bun install
```

## 4. アカウント認証

認証情報 (`antigravity-accounts.json`) はセキュリティのため同期していません。
新しい環境で再度ログインを行ってください。

```bash
# OpenCode CLIを使用する場合
opencode login
```
