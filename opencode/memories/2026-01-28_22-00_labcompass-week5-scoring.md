---
title: LabCompass - Week 5 スコアリング機能実装完了
date: 2026-01-28T22:00:00+09:00
topics: [labcompass, rails, scoring, university-field-score, score-calculator, recalculate-job]
summary: UniversityFieldScoreモデル、ScoreCalculatorService、RecalculateScoresJobを実装完了。全410テストパス。
---

# LabCompass Week 5 Development - Scoring Feature Complete

## 完了したタスク

### 1. UniversityFieldScore モデル (38 specs) ✅
- `app/models/university_field_score.rb`
- `db/migrate/20260128122955_create_university_field_scores.rb`
- 大学×分野のスコアリング結果を保存
- スコア: quality_score, funding_score, trend_score, industry_score, overall_score, cost_performance_score
- 統計: researcher_count, grant_count, total_funding, publication_count, total_citations
- ラベル: 世界注目, 爆伸び中, 少数精鋭, プロ直結, 穴場
- スコープ: for_field, for_university, top_in_field, with_label, needs_recalculation

### 2. ScoreCalculatorService (17 specs) ✅
- `app/services/score_calculator_service.rb`
- 大学×分野ごとのスコア計算ロジック
- 質スコア: 論文数×0.3 + 被引用数×0.7（分野内正規化）
- 資金スコア: 総資金額を分野内で正規化
- トレンドスコア: 直近3年 / 過去5年の伸び率
- 産学連携スコア: 企業共著論文の割合
- 総合スコア: quality×0.4 + funding×0.3 + trend×0.2 + industry×0.1
- コスパスコア: 総合スコア - 大学偏差値
- ラベル自動判定

### 3. RecalculateScoresJob (18 specs) ✅
- `app/jobs/recalculate_scores_job.rb`
- スコア一括再計算バックグラウンドジョブ
- field_id, university_id, force オプション対応
- SyncLog連携（進捗追跡）
- エラーハンドリング（個別失敗でも継続）

## Git状態
- ブランチ: main (未コミット)
- テスト: **410 examples, 0 failures**

## 次のステップ候補
1. 変更をコミット＆push
2. KeywordFieldMapping - キーワード→分野マッピング実装
3. UniversityFieldSearch - 検索クエリビルダー
4. Meilisearch統合 - 検索インデックス

## 新規追加ファイル
- `app/models/university_field_score.rb`
- `app/services/score_calculator_service.rb`
- `app/jobs/recalculate_scores_job.rb`
- `db/migrate/20260128122955_create_university_field_scores.rb`
- `spec/models/university_field_score_spec.rb`
- `spec/factories/university_field_scores.rb`
- `spec/services/score_calculator_service_spec.rb`
- `spec/jobs/recalculate_scores_job_spec.rb`

## 参照ドキュメント
- `docs/technical/06_database_schema.md` - UniversityFieldScore定義
- `docs/technical/07_development_plan.md` - Week 5計画
