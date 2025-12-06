return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = function()
      local prompts = require("config.copilot_prompts")
      return {
        auto_insert_mode = true,
        window = {
          width = 0.4,
        },
        prompts = prompts,
      }
    end,
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "x" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({ prompt = "Quick Chat: " }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>af",
        function()
          -- 'selection'オプションを使用
          local selection = vim.fn.mode() == "v"
            or vim.fn.mode() == "V"
            or vim.fn.mode() == "ctrl-v" and require("CopilotChat.select").selection()
            or {}
          require("CopilotChat").ask("Fix this code and explain the changes.", { selection = selection })
        end,
        desc = "Fix (CopilotChat)",
        mode = { "n", "x" }, -- ノーマルモードとビジュアルモードで有効
      },
      {
        "<leader>ar",
        function()
          local selection = vim.fn.mode() == "v"
            or vim.fn.mode() == "V"
            or vim.fn.mode() == "ctrl-v" and require("CopilotChat.select").selection()
            or {}
          require("CopilotChat").ask(
            "Refactor this code to be more efficient and idiomatic.",
            { selection = selection }
          )
        end,
        desc = "Refactor (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>ad",
        function()
          local selection = vim.fn.mode() == "v"
            or vim.fn.mode() == "V"
            or vim.fn.mode() == "ctrl-v" and require("CopilotChat.select").selection()
            or {}
          require("CopilotChat").ask("Explain this code.", { selection = selection })
        end,
        desc = "Explain (CopilotChat)",
        mode = { "n", "x" },
      },
    },
  },
}
