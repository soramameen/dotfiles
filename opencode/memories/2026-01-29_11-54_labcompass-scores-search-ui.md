---
title: LabCompass RecalculateScoresJob実行 & 検索UI動作確認
date: 2026-01-29T11:54:00+09:00
topics: [LabCompass, RecalculateScoresJob, UniversityFieldScore, 検索UI, Rails]
summary: RecalculateScoresJobをforce実行し、UniversityFieldScoreを34件→81件に拡大。検索UI（rankings#index）でキーワード検索→大学×分野一覧が正常動作することを確認。67件にoverall_scoreあり、一部はPublication年データ不足でquality_scoreがnil。
---

# LabCompass RecalculateScoresJob実行 & 検索UI動作確認

## 実施内容

### 1. RecalculateScoresJob実行
```ruby
RecalculateScoresJob.perform_now(force: true)
```
- UniversityFieldScore: 34件 → **81件**（Grant pairsと同数）
- overall_scoreあり: **67件**
- スコアがnilの14件: Publication.publication_yearがnullのためquality_score計算不可

### 2. 検索UI動作確認
`http://localhost:3000/` (rankings#index) で以下を確認：
- ✅ キーワード検索（「知能」で14件ヒット）
- ✅ 大学×分野一覧のカード表示
- ✅ スコア表示（overall, quality, trend, コスパ, funding, 産学連携）
- ✅ ラベルバッジ（穴場、爆伸び中など）
- ✅ フィルタ（大学カテゴリ）、ソート（6種類）
- ✅ ページネーション（81件/20件表示）

## 現在のデータ状態

| データ | 件数 | 備考 |
|--------|------|------|
| Universities | 120 | 全て偏差値設定済み |
| Grants | 149 | AI関連キーワードで同期済み |
| Publications | 438 | publication_year全てnull |
| UniversityFieldScores | 81 | 67件にスコアあり |

## 未解決課題

### Publication年データの欠損
- `Publication.publication_year` が全てnull
- これにより `quality_score` が計算されない（論文数・被引用数の評価不可）
- `ScoreCalculatorService#calculate_quality_score` が `nil` を返す

### 影響
- 14件のUniversityFieldScoreがoverall_score=nil
- quality_scoreが全体的にnil（表示上は「-」）

## 関連ファイル
- `app/jobs/recalculate_scores_job.rb` - スコア再計算ジョブ
- `app/services/score_calculator_service.rb` - スコア計算ロジック
- `app/controllers/rankings_controller.rb` - 検索API
- `app/services/university_field_search.rb` - 検索クエリビルダー
- `app/views/rankings/index.html.erb` - 検索UI

## 次回セッション用プロンプト

```
Recall memory "labcompass-scores-search-ui".

次のアクションを選択してください：

1. **Publication年データの修正**: publication_yearをGrantやDOIから推定・更新し、quality_scoreを計算可能にする
2. **データ拡充**: 他のキーワード（量子、がん、機械学習等）でSyncGrantsJob実行
3. **UIポリッシュ**: レスポンシブ対応、追加フィルタ（都道府県、偏差値範囲）
4. **本番デプロイ準備**: docker-compose本番設定、Meilisearchインデックス構築
```
