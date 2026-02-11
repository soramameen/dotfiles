# nvim

Neovimの設定ディレクトリ。

## ディレクトリ構成

```
nvim/
├── init.lua                      # エントリーポイント
├── lazy-lock.json                # プラグインのバージョン固定
└── lua/
    ├── config/
    │   ├── options.lua           # Vimオプション（行番号、インデント等）
    │   └── keymaps.lua           # キーマップ（Rails, Obsidian, AI等）
    └── plugins/
        ├── init.lua              # プラグイン読み込みのエントリーポイント
        ├── colorscheme.lua       # カラースキーム (tokyonight)
        ├── editor.lua            # エディタコア機能
        ├── lsp.lua               # LSP (Language Server Protocol)
        ├── completion.lua        # 補完 (nvim-cmp)
        ├── git.lua               # Git関連
        ├── rails.lua             # Rails開発支援
        ├── ai.lua                # AIアシスタント (OpenCode)
        ├── obsidian.lua          # Zettelkasten (Obsidian.nvim)
        ├── markdown.lua          # Markdown記述
        └── latex.lua             # LaTeX執筆 (VimTeX)
```

## 各プラグインファイルの担当

### colorscheme.lua
- **tokyonight.nvim**: カラースキーム

### editor.lua
- **Treesitter**: シンタックスハイライト
- **Telescope**: ファイル検索・文字列検索 (`<leader>ff`, `<leader>fg`)
- **Neo-tree**: ファイルツリー (`<leader>e`)
- **Flash.nvim**: 高速カーソル移動 (`s`, `S`)
- **WhichKey**: キーマップヘルプ

### lsp.lua
- **nvim-lspconfig**: LSPクライアント
- **mason.nvim**: LSPサーバー管理ツール
- **mason-lspconfig**: MasonとLSPの連携
- **ruby_lsp**: Ruby言語サーバー（システムのshimを使用）
- **LSPキーマップ**: `gd`（定義ジャンプ）, `K`（ホバー）, `<leader>rn`（リネーム）, `<leader>ca`（コードアクション）

### completion.lua
- **nvim-cmp**: 補完エンジン
- **cmp-nvim-lsp**: LSP補完ソース
- **cmp-buffer**: バッファ内単語補完
- **cmp-path**: ファイルパス補完
- **LuaSnip**: スニペットエンジン
- **friendly-snippets**: VS Code形式のスニペット集

### git.lua
- **LazyGit**: Git UI (`<leader>g`)
- **Diffview**: Git diffビューア (`<leader>d`)

### rails.lua
- **vim-rails**: Rails開発支援
  - `<leader>ra`: コード↔テスト往復
  - `<leader>rm`: Modelへ移動
  - `<leader>rc`: Controllerへ移動
  - `<leader>rv`: Viewへ移動
  - `<leader>rs`: schema.rbを開く
  - `<leader>rr`: routes.rbを開く

### ai.lua
- **OpenCode**: AIアシスタント
  - `<C-Space>`: AIに質問（ノーマルモード: バッファ全体、ビジュアルモード: 選択範囲）
  - `<C-x>`: OpenCodeアクション
  - `<C-.>`: トグル

### obsidian.lua
- **Obsidian.nvim**: Zettelkastenツール
  - `<leader>on`: 新規Inboxノート
  - `<leader>op`: 新規Permanentノート
  - `<leader>os`: ノート検索
  - `<leader>od`: デイリーノート
  - `<leader>ot`: テンプレート挿入
  - `<leader>oc`: 選択範囲をConceptとして登録

### markdown.lua
- **render-markdown.nvim**: Markdownの装飾表示
- **peek.nvim**: Markdownプレビュー (`<leader>m`)
- **img-clip.nvim**: 画像貼り付け (`<leader>p`)
- **image.nvim**: 画像プレビュー（Kittyプロトコル）

### latex.lua
- **VimTeX**: LaTeX執筆支援
  - Skimとの連携（PDFプレビュー・逆サーチ）
  - latexmkでの自動コンパイル

## 追加する場合

### 新しいプラグインを追加する場合

1. **適切なファイルを選択**（または新規作成）
   - エディタ機能 → `editor.lua`
   - LSP関連 → `lsp.lua`
   - 補完関連 → `completion.lua`
   - Git関連 → `git.lua`
   - 言語固有（Rust, Go等）→ 新規 `lang/rust.lua` 等

2. **プラグインスペックを記述**
   ```lua
   return {
     "author/repo.nvim",
     dependencies = { "dependency1", "dependency2" },
     keys = { "<leader>x" },  -- キーマップがある場合
     config = function()
       -- 設定
     end,
   }
   ```

3. **`plugins/init.lua` にrequireを追加**
   ```lua
   return {
     require("plugins.colorscheme"),
     require("plugins.editor"),
     require("plugins.lsp"),
     -- ...
     require("plugins.newfile"),  -- 追加
   }
   ```

### 新しい言語サポートを追加する場合

`lua/plugins/lang/` ディレクトリを作成し、言語ごとに分割：

```
plugins/lang/
├── ruby.lua      # vim-rails, ruby_lsp等
├── rust.lua      # rust_analyzer
├── go.lua        # gopls
└── typescript.lua # ts_server
```

## キーマップ一覧

| キー | 機能 | ファイル |
|------|------|---------|
| `jj` | Insert mode → Normal mode | `config/keymaps.lua` |
| `<leader>ff` | ファイル検索 | `plugins/editor.lua` (Telescope) |
| `<leader>fg` | 文字列検索 | `plugins/editor.lua` (Telescope) |
| `<leader>e` | ファイルツリー開閉 | `plugins/editor.lua` (Neo-tree) |
| `<leader>g` | LazyGit起動 | `plugins/git.lua` |
| `<leader>d` | Diffviewトグル | `plugins/git.lua` |
| `<C-Space>` | AIに質問 | `plugins/ai.lua` |
| `gd` | 定義ジャンプ | `plugins/lsp.lua` |
| `K` | ホバー表示 | `plugins/lsp.lua` |
| `<C-Space>` | 補完 | `plugins/completion.lua` |

## メンテナンス

### プラグインを更新する場合
```bash
nvim --headless "+Lazy! sync" +qa
```

### 新しいマシンでセットアップする場合
1. `nvim/` を `~/.config/nvim` にシンボリックリンク
2. `nvim` を起動（自動でlazy.nvimがインストールされる）
3. `:Lazy` でプラグインを同期
