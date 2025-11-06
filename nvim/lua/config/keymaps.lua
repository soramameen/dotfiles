-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
-- ^（キャレット）は行頭の空白文字でない最初の文字へ移動します。
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "行頭へ移動 (非空白文字)" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "行末へ移動" })
local g = vim.g

-- 1. ノーマルモード時のIME OFFを保証
-- ノーマルモードに入ったとき（InsertLeave）にIMEをOFFにする
g.im_select_id = 1 -- IME OFF の状態ID。macOSは1、Windowsは2が多い（要確認）
vim.cmd([[
  augroup IMEControl
    autocmd!
    " 挿入モードからノーマルモードへ離脱するとき
    autocmd InsertLeave * silent !im-select 1
  augroup END
]])
