---
name: memory-saver
description: 現在の会話内容・作業状況を要約し、~/.config/opencode/memories/ にMarkdownファイルとして保存。トピック名をファイル名に含める。
user-invocable: true
disable-model-invocation: false
license: MIT
compatibility: opencode,claude
metadata:
  audience: 全てのユーザー
  workflow: 長期記憶管理
---

## 保存原則
- 保存先: `~/.config/opencode/memories/`
- ファイル名形式: `YYYY-MM-DD_HH-MM-SS_[トピック].md`
- 内容: YAML frontmatter (title, date, topics, summary) + 本文（会話キー決定事項、コード、TODOなど）

## 保存手順
1. トピック名確認（$ARGUMENTS or 推定）
2. 会話・作業状況を要約（300-800文字）
3. bashでファイル作成・書き込み
4. 保存完了を報告（ファイル名表示）

## When to use me
- 会話の重要な区切り時
- 「記憶して」「保存して」と言われた時
- 自動: 長会話終了時や進捗節目
