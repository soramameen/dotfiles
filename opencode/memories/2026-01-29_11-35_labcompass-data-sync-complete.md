---
title: LabCompass 偏差値CSV完成 & 初回データ同期完了
date: 2026-01-29
topics: [LabCompass, Rails, CiNii, OpenAlex, SyncGrantsJob, SyncCitationsJob, 偏差値, データ同期]
summary: 偏差値CSVを全120大学分に拡張・インポート完了。初回SyncGrantsJob（AI関連キーワード）で149件のGrantと438件のPublicationを取得。SyncCitationsJobでDOI付き論文124件の被引用数を同期。
---

# LabCompass 偏差値CSV完成 & 初回データ同期完了

## 今回の完了項目

### 1. 偏差値CSV完成
- `db/seeds/deviation_values.csv` を全120大学分に拡張
- `rake universities:import_deviation` で全大学にインポート完了
- 偏差値範囲: 45（北海学園大学等）〜 75（東京大学、慶應医学部）

### 2. 環境変数修正
- `.env` に `CINII_APP_ID` を追加（KAKEN_API_KEYと同値）
- 余分な改行・スペースを修正

### 3. 初回SyncGrantsJob実行
- キーワード「AI」（2024-2025年）で同期
- 結果: Grants 47 → 149件（+102）
- 結果: Publications 0 → 438件
- SyncLog: success

### 4. 初回SyncCitationsJob実行
- DOI付き論文124件を処理
- OpenAlex APIから被引用数データ取得
- SyncLog: success（processed: 124, updated: 0）
- 新しい論文が多いため引用数は0が多い

## 最終データ状態

| データ | 件数 |
|--------|------|
| Universities | 120（全て偏差値設定済み） |
| Grants | 149 |
| Publications | 438（DOI付き: 124） |
| Fields | 101（小区分: 76） |
| UniversityFieldScores | 34 |

## 次のアクション（推奨）

### データ拡充
1. **大規模SyncGrantsJob実行**: 全分野（76小区分）を順次同期
2. **キーワード追加同期**: 「量子」「がん」「機械学習」等の主要キーワード
3. **年度範囲拡大**: 2020-2025年でより多くのデータ取得

### スコア計算
1. **RecalculateScoresJob実行**: 同期したデータでスコア再計算
2. **ラベル生成**: world_attention, rapid_growth等のラベル付与

### フロントエンド
1. **検索UI実装**: キーワード検索 → 大学×分野一覧
2. **スコア表示**: overall_score, cost_performance_score
3. **ラベルバッジ**: 各種ラベルの視覚的表示

## 関連ファイル
- `db/seeds/deviation_values.csv` - 全120大学の偏差値
- `app/jobs/sync_grants_job.rb` - CiNii科研費同期
- `app/jobs/sync_citations_job.rb` - OpenAlex被引用数同期
- `config/recurring.yml` - 定期実行設定
- `.env` - API keys (KAKEN_API_KEY, CINII_APP_ID, OPEN_ALEX_API_KEY)

## 使用コマンド

```ruby
# 偏差値インポート
rake universities:import_deviation

# 科研費同期（キーワード指定）
SyncGrantsJob.perform_now(keyword: 'AI', year_from: 2024, year_until: 2025)

# 被引用数同期
SyncCitationsJob.perform_now(force: true)

# スコア再計算
RecalculateScoresJob.perform_now
```

