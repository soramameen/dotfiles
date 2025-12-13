return {
  -- 1. カラースキーム (Tokyo Night)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- 2. Treesitter (シンタックスハイライト)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown" },
        auto_install = true,
        --- latexだけバージョンが足りないので除外
        ignore_install = {"latex"},
        highlight = { enable = true },
      })
    end,
  },

  -- 3. Telescope (あいまい検索)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- ファイル検索
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})  -- 文字列検索
    end,
  },

  -- 4. WhichKey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  },
  -- 5. Neo-tree (サイドバーのファイルツリー)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- アイコン用
      "MunifTanjim/nui.nvim",        -- UIコンポーネント
    },
    -- キー設定: Space + e で開閉
    keys = {
      { "<leader>e", ":Neotree toggle left<CR>", desc = "Explorer NeoTree" },
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true, -- 隠しファイルを表示するかどうか
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
    end,
  },
  -- 7. LSP (言語サーバー設定)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 1. Mason (インストーラー) の設定
      require("mason").setup()

      -- 2. Mason-LSPConfig (橋渡し) の設定
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ruby_lsp" },

        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
        },
      })

      -- 3. キーマップ設定 (LSPが繋がったときだけ有効になるキー)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- 定義ジャンプ
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })
          -- ホバー
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover Documentation" })
          -- リネーム
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
          -- コードアクション
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            { buffer = ev.buf, desc = "Code Action" }
          )
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf, -- 今開いているバッファだけで有効にする
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",            -- 入力モードに入ったら読み込む
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",         -- LSPソース (脳みそからの候補)
      "hrsh7th/cmp-buffer",           -- バッファ内単語
      "hrsh7th/cmp-path",             -- ファイルパス
      "L3MON4D3/LuaSnip",             -- スニペットエンジン
      "saadparwaiz1/cmp_luasnip",     -- スニペット連携
      "rafamadriz/friendly-snippets", -- 定型文集 (VS Code互換)
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- VS Code形式のスニペットを読み込む
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        -- スニペットエンジンの設定（必須）
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- キー設定 (LazyVim風)
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),        -- 前の候補 (Ctrl+k)
          ["<C-j>"] = cmp.mapping.select_next_item(),        -- 次の候補 (Ctrl+j)
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- 説明スクロール (上)
          ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- 説明スクロール (下)
          ["<C-Space>"] = cmp.mapping.complete(),            -- 強制的に補完を出す
          ["<C-e>"] = cmp.mapping.abort(),                   -- 閉じる
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enterで確定
        }),
        -- 補完の優先順位
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP (ruby_lspなど)
          { name = "luasnip" },  -- スニペット
        }, {
          { name = "buffer" },   -- バッファ内の単語
          { name = "path" },     -- ファイルパス
        }),
      })
    end,
  },
}
