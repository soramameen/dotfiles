return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    cmd = {
      "ObsidianNew",
      "ObsidianSearch",
      "ObsidianToday",
      "ObsidianTemplate",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "mydream",
            path = "/Users/nakajimasoraera/Library/Mobile Documents/iCloud~md~obsidian/Documents/mydream",
          },
        },
        new_notes_location = "notes_subdir",
        notes_subdir = "Zettelkasten/Inbox",

        daily_notes = {
          folder = "毎日振り返り",
          date_format = "%Y-%m-%d",
        },

        templates = {
          folder = "template",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
        },

        note_id_func = function(title)
          if title ~= nil then
            return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            return os.date("%Y%m%d_%H%M")
          end
        end,

        disable_frontmatter = true,

        mappings = {
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>ch"] = {
            action = function()
              return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
          },
        },

        ui = {
          enable = false,
        },
      })
    end,
  },
}
