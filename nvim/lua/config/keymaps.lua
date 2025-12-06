-- リーダーキーをスペースに設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode" })

keymap.set({ "n", "v" }, "H", "^", { desc = "Move to beginning of line" })
keymap.set({ "n", "v" }, "L", "$", { desc = "Move to end of line" })

-- 画面分割
-- <Leader> + | (パイプ) で縦分割
keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Split window vertically" })
-- <Leader> + - (ハイフン) で横分割
keymap.set("n", "<leader>-", ":split<CR>", { desc = "Split window horizontally" })

-- 画面間の移動 (Ctrl + h/j/k/l)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- 画面サイズ変更 (矢印キーで調整)
keymap.set("n", "<Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
