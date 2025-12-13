return {
  -- ★ 以前あった { import = "..." } の行は削除しました。
  -- これにより "No specs found" エラーは発生しなくなります。

  -----------------------------------------------------------------------------
  -- 1. VimTeX 本体と日本語環境・PDFビューワー設定
  -----------------------------------------------------------------------------
  {
    "lervag/vimtex",
    lazy = false, -- 起動時に読み込む（PDFからの逆サーチ機能のため）
    init = function()
      -- === PDFビューワー設定 (Skim) ===
      vim.g.vimtex_view_method = "skim"

      -- === 日本語コンパイラ設定 (latexmk) ===
      vim.g.vimtex_compiler_latexmk = {
        background = 1,
        build_dir = "",
        continuous = 1,
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end,
    config = function()
      -- VimTeXのキー競合対策 (LSPのホバー 'K' と競合しないようにする)
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
    end,
  },

  -----------------------------------------------------------------------------
  -- 2. Treesitter (シンタックスハイライト) の設定
  -----------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- ensure_installed がない場合に備えて初期化
      opts.ensure_installed = opts.ensure_installed or {}
      
      -- リスト形式であることを確認してから latex, bibtex を追加
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
      end
    end,
  },
}
