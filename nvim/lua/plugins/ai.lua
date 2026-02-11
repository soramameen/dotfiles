return {
  {
    "NickvanDyke/opencode.nvim",
    config = function()
      vim.g.opencode_opts = {
        provider = {
          enabled = "tmux",
        },
      }
      vim.o.autoread = true

      local opencode = require("opencode")

      vim.keymap.set(
        "n",
        "<C-Space>",
        function()
          opencode.ask("@buffer: ", { submit = true })
        end,
        { desc = "Ask opencode (Buffer)" }
      )
      vim.keymap.set(
        "x",
        "<C-Space>",
        function()
          opencode.ask("@this: ", { submit = true })
        end,
        { desc = "Ask opencode (Selection)" }
      )
      vim.keymap.set(
        { "n", "x" },
        "<C-x>",
        function()
          opencode.select()
        end,
        { desc = "Opencode Actions" }
      )
      vim.keymap.set(
        { "n", "t" },
        "<C-.",
        function()
          opencode.toggle()
        end,
        { desc = "Toggle opencode" }
      )

      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
    end,
  },
}
