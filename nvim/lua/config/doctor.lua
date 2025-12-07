-- ==========================================
--  AI Doctor (エラー診断機能)
-- ==========================================
vim.api.nvim_create_user_command('Doc', function()
  -- 1. 現在行のエラー診断情報を取得
  local lnum = vim.fn.line('.') - 1 -- Luaは0始まり
  local diagnostics = vim.diagnostic.get(0, { lnum = lnum })

  -- エラーがなければ終了
  if #diagnostics == 0 then
    print("👍 健康です！ (この行にエラーはありません)")
    return
  end

  -- 2. エラーメッセージをまとめる
  local error_messages = {}
  for _, d in ipairs(diagnostics) do
    table.insert(error_messages, string.format("[%s] %s", d.source or "LSP", d.message))
  end
  local error_text = table.concat(error_messages, "\n")

  -- 3. エラーが起きている周辺のコードを取得 (前後3行くらいあると文脈がわかる)
  local start_line = math.max(0, lnum - 3)
  local end_line = math.min(vim.api.nvim_buf_line_count(0), lnum + 4)
  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
  local code_context = table.concat(lines, "\n")

  print("🚑 AiDoctorが診断中...")

  -- 4. 質問文を作成 (エラー内容 + '解説して' )
  local prompt = "以下のエラーが出ています。原因と修正案を教えてください。\n\nエラー内容:\n" .. error_text
  local safe_prompt = vim.fn.shellescape(prompt)
  
  -- コード内のクォートをエスケープ
  local safe_code = code_context:gsub('"', '\\"')

  -- 5. 既存のPythonスクリプトを再利用！
  -- echo "周辺コード" | python ask_ai.py "エラー解説依頼"
  local cmd = string.format('echo "%s" | %s %s %s 2>&1', safe_code, python_path, script_path, safe_prompt)

  -- 実行 & 表示 (既存の処理と同じ)
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()

  if result then
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.cmd('vsplit')
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
    local output_lines = vim.split(result, "\n")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, output_lines)
    vim.api.nvim_set_option_value('wrap', true, { win = win })
  else
    print("エラー: ドクターからの応答がありません")
  end

end, {})
