vim.lsp.config("emmet_language_server", {
  init_options = {
    preferences = {
      ["output.indent"] = "    ", -- 4 spaces
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    -- etc.
  end,
})

vim.diagnostic.config({
  virtual_lines = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  virtual_text = {
    current_line = true,
    severity = { max = vim.diagnostic.severity.WARN },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "css",
  callback = function()
    -- Checks if the file path contains "waybar"
    if vim.fn.expand("%:p"):match("waybar") then
      vim.diagnostic.enable(false, { bufnr = 0 })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "css",
  callback = function()
    -- Checks if the file path contains "wlogout"
    if vim.fn.expand("%:p"):match("wlogout") then
      vim.diagnostic.enable(false, { bufnr = 0 })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "css",
  callback = function()
    -- Checks if the file path contains "swaync"
    if vim.fn.expand("%:p"):match("swaync") then
      vim.diagnostic.enable(false, { bufnr = 0 })
    end
  end,
})

vim.lsp.enable("eslint")

vim.lsp.config("qmlls", {
  cmd = { "qmlls6" },
  filetypes = { "qml" },
  root_markers = { ".git", "CMakeLists.txt" },
})
vim.lsp.enable("qmlls")
