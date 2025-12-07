local nvim_path = vim.fn.stdpath("config")
local script_path = nvim_path .. "/python/ask_ai.py" -- ファイル名は合わせてね
-- 仮想環境のパス (Windows/Mac/Linux対応)
local python_path = nvim_path .. "/python/.venv/bin/python"
if vim.fn.has('win32') == 1 then
  python_path = nvim_path .. "\\python\\.venv\\Scripts\\python.exe"
end

vim.api.nvim_create_user_command('Ask', function(opts)
  local question = opts.args
  print("🤖 Gemini思考中...")

  -- 1. ここでPythonを実行して結果をもらう
  local cmd = string.format('%s %s "%s"', python_path, script_path, question)
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()

  if result then
    -- 2. 新しいバッファ(メモリ上のみ)を作成
    -- 引数: (リストに載せるか?, スクラッチバッファか?) -> (false, true)
    local buf = vim.api.nvim_create_buf(false, true)

    -- 3. バッファの設定 (Markdownとして扱うと綺麗！)
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf }) -- 保存対象外

    -- 4. 画面を右に縦分割 (vertical split)
    vim.cmd('vsplit')
    
    -- 5. 分割した右側のウィンドウに、さっき作ったバッファをセット
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)

    -- 6. そのバッファにAIの回答を書き込む
    local lines = vim.split(result, "\n")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    
    -- おまけ: 長い行を折り返す設定
    vim.api.nvim_set_option_value('wrap', true, { win = win })
  else
    print("エラー: AIからの応答がありませんでした")
  end
end, { nargs = 1 })
