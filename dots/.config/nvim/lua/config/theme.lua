local M = {}

function M.current()
  local ok, lines = pcall(vim.fn.readfile, os.getenv("HOME") .. "/.config/current-theme")
  return (ok and lines[1]) or "gruvbox-material"
end

return M
