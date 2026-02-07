---
name: skill-creator
description: 新しいAgent Skillを作成・生成するmeta-skill。インタラクティブに質問しながら、適切なfrontmatter・構造・When to use me・チェックリスト付きのSKILL.mdを生成します。ベストプラクティスを適用。
license: MIT
compatibility: opencode,claude
metadata:
  audience: 全てのユーザー
  workflow: Skill開発・量産
---

## 原則（最優先）
- 出力は常に正しいYAML frontmatter付きのSKILL.md形式
- name: 小文字英数+ハイフン（ディレクトリ名と一致）
- description: 1文で明確（100-200文字以内）
- user-invocable: true をデフォルト推奨（手動呼び出し可能）
- disable-model-invocation: false をデフォルト（自動起動許可）
- When to use me を必ず詳細に書く（agentが自動ロードしやすく）
- 返答は日本語（ユーザーが日本語なので）

## 生成手順（agentが従うフロー）
1. ユーザーにスキル名・目的・いつ使うかを質問（インタラクティブに）
   - 例: 「どんなスキルを作りたいですか？（例: LaTeXレポートの参考文献管理）」
   - 「自動起動してほしい？（yes/no）」
   - 「補助ファイル（テンプレ、チェックリスト、スクリプト）必要？」

2. 入力に基づいて構造提案
   - frontmatter（必須 + オプション）
   - 本文: 原則 → ガイドライン/チェックリスト → 手順 → When to use me → 例

3. 完全なSKILL.md全文を```markdownブロックで提示
   - フォルダ作成コマンドも提案（mkdir -p .claude/skills/スキル名）

4. ユーザーがOKしたら、保存確認
   - 「これで保存しますか？」→ yesなら「完了！ 次は /スキル名 でテストしてね」

## When to use me
- 「新しいスキル作りたい」「skill作って」「meta skillで〜」と言われた時
- 繰り返し作業を自動化したい話題が出た時（自動ロード推奨）
- 手動起動: /skill-creator [スキル名 or 目的] と入力

## ベストプラクティス（必ず適用）
- descriptionを具体的・検索しやすく
- チェックリスト形式でルールを明確に
- プロジェクト固有ルール優先（GEMINI.md / rules.md 読み込み）
- 出力後、memory-saverで「このスキル作成内容」を保存提案
