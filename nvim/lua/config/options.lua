local opt = vim.opt

-- 行番号を表示
opt.number = true
opt.relativenumber = true -- 相対行番号（好みが分かれますが便利です）

-- インデント設定 (スペース2つ)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- クリップボードをOSと共有
opt.clipboard = "unnamedplus"

-- 検索設定
opt.ignorecase = true -- 大文字小文字を無視
opt.smartcase = true -- 大文字が含まれる場合のみ区別

-- その他
opt.cursorline = true -- 現在行をハイライト
opt.termguicolors = true -- True Colorを使用
opt.signcolumn = "yes" -- 左端のサイン列を常に表示（ガタつき防止）
