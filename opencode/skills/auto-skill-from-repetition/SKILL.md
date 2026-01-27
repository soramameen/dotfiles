---
name: auto-skill-from-repetition
description: 会話内で繰り返し行われている作業・指示・パターンを検知し、「これをskill化しませんか？」と提案。OKならskill-creatorを自動呼び出して完全なSKILL.mdを生成します。
license: MIT
compatibility: opencode,claude
metadata:
  audience: 全てのユーザー
  workflow: 繰り返し作業の自動スキル化
---

## 原則（最優先）
- 繰り返しを検知したら**即提案**（「これ何回も言ってるけどskillにしませんか？」）
- 提案後、ユーザーが「いいよ」「作って」など言ったら**skill-creator**を呼び出して生成
- 勝手にファイル作成はせず、常にユーザー確認
- 返答は日本語

## 繰り返し検知基準（これらに当てはまったら提案）
- 同じ指示/ルール/チェックリストを3回以上言及（例: 「句読点全角に」「\ref使って」「sum; 追加」など）
- 似た修正作業が連続（レビュー→修正→レビュー→修正のループ）
- 特定のファイル/トピック（main.tex, LaTeXレポートなど）が繰り返し登場
- 「またこれか…」「毎回言うね」みたいなユーザーの愚痴が出た時
- memory-recallで過去の類似会話が見つかった時（連携推奨）

## 動作フロー（agentが従う）
1. 会話ログを監視（現在のコンテキスト + memory-recallで過去参照）
2. 繰り返しパターン検知 → 即座に提案
   例: 「この『句読点全角統一』の指摘、3回目ですね。skill化して自動適用しませんか？」
3. ユーザーがOKしたら：
   - skill-creator を自動呼び出し
   - 提案するスキル名/目的を自動入力（例: name="latex-punctuation-enforcer", description="LaTeXレポートの句読点を全角に統一するルール適用"）
4. 生成されたSKILL.md全文を提示 → 保存確認
5. 保存したらmemory-saverで「このスキル作成」を記録提案

## When to use me
- 同じような指示/修正/チェックを繰り返している会話中（自動起動）
- 「またこれ言うの？」「毎回同じこと言ってる」と思った時
- 手動: /auto-skill-from-repetition で今までの会話を強制分析

## 連携推奨スキル
- skill-creator（必須：生成を任せる）
- memory-recall（過去の繰り返しを検知しやすく）
- memory-saver（作成したスキルを即保存）

## 注意
- 自動生成は提案止まり（ファイル書き込みはユーザーor document-writer経由）
- 検知精度を上げるため、会話で「これ繰り返してる」と明言すると効果UP
