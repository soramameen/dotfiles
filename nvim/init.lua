-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- ~/.config/nvim/lua/config/lazy.lua
-- このファイルに以下の内容を貼り付けます

return {
  -- デフォルトのカラースキームを設定 (例: tokyonight)
  -- もしお好みがなければ、この行は削除しても構いません
  colorscheme = "tokyonight",

  -- ここに 'extras' の設定を追加します
  extras = {
    -- 他にもし使いたい 'extras' があればここに追加します
    -- (例: "lazyvim.plugins.extras.lang.typescript")
    -- (例: "lazyvim.plugins.extras.lang.json")

    -- ↓ 今回追加するRuby用の設定
    "lazyvim.plugins.extras.lang.ruby",
  },

  -- プラグインのデフォルト設定を上書きする場合は
  -- 以下のように `plugins` テーブルを使います (今回は不要です)
  -- plugins = {
  --   {
  --     "folke/tokyonight.nvim",
  --     lazy = false,
  --     priority = 1000,
  --     opts = {},
  --   },
  -- },

  -- 必要に応じて他のLazyVimオプションを設定できます
  -- (例: ui.border = "rounded",)
}
