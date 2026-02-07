---
title: LabCompass API検証 - 偏差値・被引用数取得方法の決定
date: 2026-01-29
topics: [LabCompass, API, 偏差値, 被引用数, OpenAlex, CiNii]
summary: 被引用数取得はOpenAlex API採用決定。偏差値は正式APIが存在せず、みんなの大学情報からの手動取得+ライセンス交渉を推奨。
---

# LabCompass API検証結果

## 背景
- LabCompassは高校生向け研究室発見プラットフォーム
- `quality_score = 論文数×0.3 + 被引用数×0.7`の計算に被引用数が必要
- `cost_performance_score = overall_score - 偏差値`の計算に偏差値が必要

## 被引用数API - 検証結果

### 採用: OpenAlex API ⭐⭐⭐
- **成功率**: 4/4
- **API Key**: `.env`に`OPEN_ALEX_API_KEY`設定済み
- **フィールド**: `cited_by_count`で直接取得
- **日本研究**: 22,441件ヒット確認
- **レート制限**: 10万リクエスト/日（無料）

### 代替: Semantic Scholar (3/4成功)、Crossref (4/4成功)

## 偏差値API - 検証結果

### 重要発見: 正式APIは存在しない

| ソース | 偏差値データ | 法的リスク |
|--------|-------------|-----------|
| みんなの大学情報 | ✅ あり | ⚠️ 高（利用規約違反リスク） |
| 大学ポートレートAPI | ❌ なし | ✅ 低 |
| e-Stat API | ❌ なし（代替指標のみ） | ✅ 低 |

### 推奨アプローチ
1. **Phase 1**: 河合塾PDFから手動でCSV作成→DBインポート
2. **Phase 2**: みんなの大学情報にライセンス契約を打診
3. **Phase 3**: e-Stat APIで入学倍率等を代替指標として検討

## 作成ファイル
- `docs/api/10_citation_hensachi_api_validation.md` - 詳細レポート
- `scripts/test_citation_apis.py` - 被引用数APIテストスクリプト
- `scripts/test_hensachi_apis.py` - 偏差値APIテストスクリプト
- `scripts/citation_api_test_results.json` - テスト結果JSON
- `scripts/hensachi_api_test_results.json` - テスト結果JSON

## 次のアクション
1. OpenAlex APIクライアント実装（Ruby）
2. Publication.citation_countカラム追加
3. 被引用数同期ジョブ作成
4. 偏差値CSV作成（河合塾PDFから手動）
5. University.deviation_valueカラム追加
