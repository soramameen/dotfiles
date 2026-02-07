---
title: GitHub Pages Setup for Obsidian Markdown Auto-Publishing
date: $(date +%Y-%m-%d)
topics:
  - GitHub Pages
  - Obsidian
  - Jekyll
  - pre-commit hook
  - GitHub Actions
  - auto-publishing
summary: Obsidianで書いたMarkdownファイルをGitHub Pagesで自動公開する仕組みを構築。pre-commit hookでpublicタグ付きファイルをpublic/ディレクトリに移動し、GitHub Actionsでgh-pagesブランチに自動デプロイ。JekyllがMarkdownをHTMLに自動変換。
---

# GitHub Pages Setup for Obsidian Markdown Auto-Publishing

## 背景
- Obsidianに移行したが、クラウド保存が必要
- Zenn ScrapはAPI対応していない
- URL共有だけで完結させたい

## 解決策
**完全無料のGitHub Pagesを採用**

## 実装内容

### 1. pre-commit hook（自動ファイル移動）
- **場所**: `.git/hooks/pre-commit`（Git追跡外、ローカルのみ）
- **機能**: `tags: - public`が含まれる.mdファイルを`public/`ディレクトリに自動移動
- **処理**:
  1. ステージされた.mdファイルをチェック
  2. `tags`に`public`が含まれる場合、`Zettelkasten/Inbox/public/`に移動
  3. 移動後のファイルを自動ステージング
  4. 元のファイルはアンステージ

### 2. GitHub Actionsワークフロー（自動デプロイ）
- **場所**: `.github/workflows/publish-public.yml`
- **機能**: `public/`ディレクトリの内容をgh-pagesブランチに自動push
- **トリガー**: main/masterブランチへのpush時

### 3. Jekyll設定（Markdown→HTML自動変換）
- **場所**: `Zettelkasten/Inbox/public/_config.yml`
- **設定**: `theme: jekyll-theme-slate`
- **機能**: Jekyllが.mdファイルを.htmlに自動変換
- **重要**: `.html`拡張子でアクセス（例: test.md → test.html）

### 4. auto-linker除外設定
- **場所**: `.pre-commit-config.yaml`
- **設定**: `exclude: ^(Zettelkasten/Inbox/public/|public/)`
- **機能**: public/ディレクトリのファイルにwiki-link `[[ ]]`を付与しない

## ワークフロー

```bash
1. Obsidianでメモを書く（Inbox/でOK）
2. tags: - public を追加
3. git commit
   ↓ pre-commit hookが自動で public/ に移動
4. git push
   ↓ GitHub Actionsが自動実行
5. https://soramameen.github.io/vault/ファイル名.html で公開
```

## 重要なパス
- pre-commit hook: `.git/hooks/pre-commit`
- GitHub Actions: `.github/workflows/publish-public.yml`
- auto-linker除外: `.pre-commit-config.yaml`（`exclude: ^(Zettelkasten/Inbox/public/|public/)`）
- Jekyll設定: `Zettelkasten/Inbox/public/_config.yml`（`theme: jekyll-theme-slate`）
- 公開対象: `Zettelkasten/Inbox/public/*.md`
- 公開URL: `https://soramameen.github.io/vault/ファイル名.html`

## 成果
- **公開サイト**: https://soramameen.github.io/vault/
- **テストページ**: https://soramameen.github.io/vault/test.html
- **自動化**: Obsidianで書く→commit→push→自動公開

## メリット
- 完全無料
- Markdown形式完全維持
- URL共有だけで完結
- 自動化（commit & pushのみ）

## デメリット
- 見た目はシンプル（GitHubのデフォルト）
- 基本全公開（プライベートメモは別管理）
