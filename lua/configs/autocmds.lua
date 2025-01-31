local function is_in_tmux()
  return vim.fn.getenv("TMUX") ~= vim.NIL
end

function UpdatePadding(padding)
  local command

  if is_in_tmux() then
    local socket = vim.fn.system("tmux show-environment | grep ALACRITTY_SOCKET | sed 's/ALACRITTY_SOCKET=//g'"):gsub("%s+", "")
    local window_id = vim.fn.system("tmux show-environment | grep ALACRITTY_WINDOW_ID | sed 's/ALACRITTY_WINDOW_ID=//g'"):gsub("%s+", "")

    command = string.format("alacritty msg -s %s config -w %d window.padding.x=%d window.padding.y=%d", socket, window_id, padding, padding)
  else
    command = string.format("alacritty msg config window.padding.x=%d window.padding.y=%d", padding, padding)
  end

  vim.fn.system(command)
end

vim.cmd [[
  augroup MyAutocmds
    autocmd!
    autocmd VimEnter * lua UpdatePadding(0)
    autocmd VimLeave * lua UpdatePadding(10)
  augroup END
]]
