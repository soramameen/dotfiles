-- リーダーキーをスペースに設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode" })

keymap.set({ "n", "v" }, "H", "^", { desc = "Move to beginning of line" })
keymap.set({ "n", "v" }, "L", "$", { desc = "Move to end of line" })

-- 画面分割
keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Split window vertically" })
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

-- help
vim.keymap.set('n', '<Leader>?', function()
  -- 1. 画面サイズを取得
  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)

  -- 2. 中央に配置する座標を計算
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- 3. バッファ（表示領域）を作成
  local buf = vim.api.nvim_create_buf(false, true)

  -- 4. ウィンドウを作成（枠線付き）
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded', -- 枠線を丸くする (none, single, double, rounded)
  })

  -- 5. チートシートファイルを読み込み専用で開く
  -- もしファイルパスが違う場合はここを書き換えてください
  vim.cmd('view ~/docs/vim_cheatsheet.txt')

  -- 6. qキーで閉じられるようにする
  vim.keymap.set('n', 'q', ':close<CR>', { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', ':close<CR>', { buffer = buf, silent = true })
  
  -- 見た目の調整（行番号なし、現在行ハイライトなし）
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.cursorline = false
end, { desc = 'Open custom cheat sheet' })
-- vim-rails
keymap.set("n", "<leader>ra", ":A<CR>", { desc = "Rails: Alternate (Code <-> Test)" })

-- 各ディレクトリのファイルへジャンプ（引数なしで実行すると今のファイルに関連するものを開く）
keymap.set("n", "<leader>rm", ":Emodel ", { desc = "Rails: Go to Model" })
keymap.set("n", "<leader>rc", ":Econtroller ", { desc = "Rails: Go to Controller" })
keymap.set("n", "<leader>rv", ":Eview ", { desc = "Rails: Go to View" })
keymap.set("n", "<leader>rs", ":Eschema<CR>", { desc = "Rails: Open schema.rb" })
keymap.set("n", "<leader>rr", ":Eroute<CR>", { desc = "Rails: Open routes.rb" })

-- 便利な補助機能
-- カーソル下のワードがパーシャルやモデル名ならそのファイルを開く (gfのラップ)
keymap.set("n", "<leader>rf", "gf", { desc = "Rails: Go to File under cursor" })

-- Obsidian
-- 新規Inbox作成 + テンプレート適用
keymap.set("n", "<leader>on", function()
  vim.cmd("ObsidianNew")
  -- 200ms後にテンプレート適用（ファイルオープン待ち）
  vim.defer_fn(function()
    vim.cmd("ObsidianTemplate Inbox_Template")
  end, 200)
end, { desc = "Obsidian: New Inbox Note" })

-- 新規PermanentNote作成 + テンプレート適用
keymap.set("n", "<leader>op", function()
  -- タイトルを受け取り、PermanentNotes配下で作成
  local title = vim.fn.input("Permanent note title (optional): ")
  if title == "" then
    vim.cmd("ObsidianNew Zettelkasten/PermanentNotes/")
  else
    vim.cmd("ObsidianNew Zettelkasten/PermanentNotes/" .. title)
  end

  -- 200ms後にテンプレート適用（ファイルオープン待ち）
  vim.defer_fn(function()
    vim.cmd("ObsidianTemplate PermanentNote_Template")
  end, 200)
end, { desc = "Obsidian: New Permanent Note" })

keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Obsidian: Search Notes" })
keymap.set("n", "<leader>od", ":ObsidianToday<CR>", { desc = "Obsidian: Daily Note" })
keymap.set("n", "<leader>ot", ":ObsidianTemplate<CR>", { desc = "Obsidian: Insert Template" })

-- Obsidian: 選択した単語をConceptsに登録
keymap.set({ "n", "v" }, "<leader>oc", function()
  -- 選択範囲またはカーソル下の単語を取得
  local text = ""
  local mode = vim.fn.mode()
  
  if mode == "v" or mode == "V" or mode == "\22" then
    -- ビジュアルモード: 選択範囲を取得
    vim.cmd('noau normal! "vy')
    text = vim.fn.getreg("v")
  else
    -- ノーマルモード: カーソル下の単語
    text = vim.fn.expand("<cword>")
  end

  if text == "" then
    print("No text selected")
    return
  end

  -- ファイル名に使えない文字を除去
  local filename = text:gsub("[/\\:*?\"<>|]", "")
  if filename == "" then return end
  
  -- Conceptsディレクトリのパス (絶対パスで指定)
  local concepts_dir = "/Users/nakajimasoraera/Library/Mobile Documents/iCloud~md~obsidian/Documents/mydream/Zettelkasten/Concepts"
  local filepath = concepts_dir .. "/" .. filename .. ".md"

  -- ファイルが存在しない場合のみ作成
  local f = io.open(filepath, "r")
  if f then
    f:close()
    print("⚠️ Already exists: " .. filename)
  else
    local file = io.open(filepath, "w")
    if file then
      file:close()
      print("✨ Concept Registered: " .. filename)
    else
      print("❌ Failed to create concept: " .. filename)
    end
  end
end, { desc = "Obsidian: Register Concept" })
