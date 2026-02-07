---
title: LabCompass 複数キーワード同期ツール作成完了
date: 2026-01-29T22:55:00+09:00
topics: [LabCompass, SyncGrantsJob, Keywords, DataSync, Rails]
summary: 90+の研究キーワード（量子、がん、機械学習等）でSyncGrantsJobを実行するためのツール群を作成。Rakeタスク、シェルスクリプト、Railsコンソールヘルパーの3種類の実行方法を用意。
---

# LabCompass 複数キーワード同期ツール作成完了

## 作成したファイル

| ファイル | 用途 |
|---------|------|
| `lib/tasks/sync_multiple_keywords.rake` | Rakeタスク（90+キーワード一括実行） |
| `bin/sync_keywords` | シェルスクリプト（バックグラウンド実行対応） |
| `bin/sync_keywords_sequential.rb` | Rubyスクリプト（カテゴリ別実行） |
| `lib/sync_helper.rb` | Railsコンソール用ヘルパー |
| `docs/technical/08_keywords_sync_guide.md` | 実行ガイドドキュメント |

## キーワードカテゴリ（90+キーワード）

- **ai**: 人工知能, 機械学習, 深層学習...
- **quantum**: 量子コンピュータ, 量子計算, 量子暗号...
- **medical**: がん, 免疫療法, iPS細胞, CRISPR...
- **robotics**: ロボット, 自動運転, ドローン...
- **environment**: 再生可能エネルギー, 脱炭素...
- **materials**: ナノテクノロジー, 超伝導, 半導体...
- **space**: 宇宙探査, 重力波, ブラックホール...
- **neuro**: 脳科学, 神経科学, アルツハイマー...
- **security**: サイバーセキュリティ, 暗号...
- **bio**: バイオインフォマティクス, プロテオミクス...
- **agriculture**: スマート農業, 植物工場...
- **disaster**: 地震, 津波, 防災...
- **physics**: 素粒子, プラズマ, 核融合...

## 実行方法（3種類）

### 1. シェルスクリプト（推奨）
```bash
bin/sync_keywords --dry-run      # プレビュー
bin/sync_keywords --background   # バックグラウンド実行
tail -f log/sync_keywords_*.log  # ログ監視
```

### 2. Rakeタスク
```bash
bundle exec rake sync:multiple_keywords DRY_RUN=true  # プレビュー
bundle exec rake sync:multiple_keywords               # 実行
bundle exec rake sync:status                          # ステータス確認
```

### 3. Railsコンソール
```ruby
require_relative 'lib/sync_helper'
SyncHelper.sync_category(:quantum)  # カテゴリ別
SyncHelper.sync_all                 # 全キーワード
SyncHelper.status                   # ステータス確認
```

## 実行後の作業

1. データ同期完了後、スコア再計算が必要：
   ```ruby
   RecalculateScoresJob.perform_now(force: true)
   ```

2. 検索UIで確認：
   - `http://localhost:3000/`
   - 新しいキーワードで検索してデータが増えているか確認

## 次回セッション用プロンプト

```
Recall memory "labcompass-keywords-sync-tools".

キーワード同期を実行しました。次のステップを選択してください：

1. **同期ステータス確認**: `bundle exec rake sync:status` の結果を解析
2. **スコア再計算**: `RecalculateScoresJob.perform_now(force: true)` 実行
3. **Publication年データ修正**: quality_score計算のためpublication_yearを補完
4. **UIポリッシュ**: レスポンシブ対応、追加フィルタ
5. **本番デプロイ準備**: docker-compose本番設定

実行中のログ: `tail -f log/sync_keywords_*.log`
```

## 注意事項

- 全キーワード実行は8〜12時間かかる可能性あり
- CiNii APIレート制限対策で5秒間隔
- 途中で止めても取得済みデータは保持される
