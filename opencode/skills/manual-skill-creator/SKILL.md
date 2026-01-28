---
name: manual-skill-creator
description: ユーザーが明示的に「SKILLを作って」と言った時に、新しいSKILLを作成する。会話内容からパターンを抽出し、YAML frontmatter + Markdown形式のSKILL.mdを生成する。
user-invocable: true
disable-model-invocation: false
license: MIT
compatibility: opencode,claude
metadata:
  audience: 全てのユーザー
  workflow: 手動スキル作成
---

## 作成原則
- ユーザーが「SKILLを作って」「skill化して」「これスキルにして」と明示的に言った時のみ起動
- 作成前に必ず保存パス（`~/.config/opencode/skills/[name]/SKILL.md`）を確認
- 既存SKILLと重複しないように事前に確認
- 返答は日本語

## 作成手順
1. **スキル名の決定**: kebab-case（例: latex-reviewer, python-formatter）
2. **記述の収集**: 会話から以下を抽出
   - スキルの目的（1行）
   - 対象ユーザー層
   - 動作フロー/手順
   - 連携推奨スキル（あれば）
   - 注意点/制約
3. **構造の決定**: 既存SKILLのYAML frontmatter形式を踏襲
4. **生成**: `~/.config/opencode/skills/[name]/SKILL.md` に書き込み
5. **確認**: 生成内容を全文提示し、修正が必要か確認

## YAML frontmatter テンプレート
```yaml
---
name: [kebab-case-name]
description: [日本語で1行で説明]
user-invocable: true  # ユーザーが明示的に呼び出すならtrue
disable-model-invocation: false
license: MIT
compatibility: opencode,claude
metadata:
  audience: [全てのユーザー / 開発者 / etc.]
  workflow: [日本語でワークフローを説明]
---
```

## When to use me
- ユーザーが「これスキルにして」「SKILLを作って」と言った時
- 特定の作業パターンを将来再利用したい時

## 連携推奨スキル
- memory-saver（作成したスキルを記録）

## 注意
- 自動検知・自動提案は `auto-skill-from-repetition` の領域
- このSKILLはあくまで**ユーザーの明示的な指示**に従う
- 作成後は `~/.config/opencode/skills/` 以下に即時反映される（再読込不要）
