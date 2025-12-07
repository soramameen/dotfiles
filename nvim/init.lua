require("config.options")
require("config.keymaps")
require("config.ai")
require("config.doctor")
-- 2. lazy.nvim のブートストラップ（自動インストール）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 3. プラグインのセットアップ (lua/plugins/init.lua を読み込む)
require("lazy").setup("plugins")


