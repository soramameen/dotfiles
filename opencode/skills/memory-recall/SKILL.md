---
name: memory-recall
description: 指定キーワードに関連する過去の記憶を ~/.config/opencode/memories/ から検索・読み込み・要約して提示。
user-invocable: true
disable-model-invocation: false
license: MIT
compatibility: opencode,claude
metadata:
  audience: 全てのユーザー
  workflow: 長期記憶検索
---

## 想起原則
- 検索対象: `~/.config/opencode/memories/*.md`
- 優先: summary/title/topics、ファイル名、日付（新しい順）

## 想起手順
1. キーワード確認（$ARGUMENTS）
2. ls で一覧取得
3. grep で候補抽出
4. 関連性高い順で3〜5件選定
5. 各ファイルを読み込み、要約提示（ファイル名、日付、要約、抜粋）

## When to use me
- 同じトピック再登場時
- 「前に話したこと」「記憶を思い出して」と言われた時
- 自動: 似た話題でコンテキスト不足時
