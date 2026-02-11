local specs = {}

vim.list_extend(specs, require("plugins.colorscheme"))
vim.list_extend(specs, require("plugins.editor"))
vim.list_extend(specs, require("plugins.lsp"))
vim.list_extend(specs, require("plugins.completion"))
vim.list_extend(specs, require("plugins.git"))
vim.list_extend(specs, require("plugins.rails"))
vim.list_extend(specs, require("plugins.ai"))
vim.list_extend(specs, require("plugins.obsidian"))
vim.list_extend(specs, require("plugins.markdown"))
vim.list_extend(specs, require("plugins.latex"))

return specs
