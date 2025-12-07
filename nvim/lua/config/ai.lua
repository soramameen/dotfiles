local nvim_path = vim.fn.stdpath("config")
local script_path = nvim_path .. "/python/ask_ai.py"
local python_path = nvim_path .. "/python/.venv/bin/python"
if vim.fn.has('win32') == 1 then
  python_path = nvim_path .. "\\python\\.venv\\Scripts\\python.exe"
end

vim.api.nvim_create_user_command('G', function(opts)
  local question = opts.args
  local input_data = ""

  if opts.range == 2 then
    -- 選択された行のテキストを取得
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    input_data = table.concat(lines, "\n")
  end

  print("🤖 Gemini思考中...")

  local cmd
  local safe_question = vim.fn.shellescape(question) -- 質問文を安全にエスケープ

  if input_data ~= "" then
    -- 選択コードがある場合: echo "コード" | python script.py "質問"
    -- コード内のダブルクォートをエスケープ処理
    local safe_input = input_data:gsub('"', '\\"')
    cmd = string.format('echo "%s" | %s %s %s 2>&1', safe_input, python_path, script_path, safe_question)
  else
    -- 質問だけの場合
    cmd = string.format('%s %s %s 2>&1', python_path, script_path, safe_question)
  end

  -- Python実行
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()

  if result then
    -- バッファ作成とウィンドウ分割
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    
    vim.cmd('vsplit')
    
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
    
    -- 結果書き込み
    local lines = vim.split(result, "\n")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value('wrap', true, { win = win })
  else
    print("エラー: AIからの応答がありませんでした")
  end
end, { nargs = 1, range = true }) -- range = true が重要！
