-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
-- ^（キャレット）は行頭の空白文字でない最初の文字へ移動します。
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "行頭へ移動 (非空白文字)" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "行末へ移動" })
local g = vim.g

-- バッファ移動
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
