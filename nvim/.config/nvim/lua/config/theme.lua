local M = {}

function M.current()
  local ok, lines = pcall(vim.fn.readfile, vim.fn.stdpath("config") .. "/current_theme")
  return (ok and lines[1]) or "gruvbox-material"
end

return M
