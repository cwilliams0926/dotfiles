vim.schedule(function()
	vim.bo.indentexpr = ""
	vim.opt_local.cindent = false
	vim.opt_local.smartindent = false
	vim.opt_local.autoindent = true
	vim.opt_local.shiftwidth = 2
	vim.opt_local.tabstop = 2
	vim.opt_local.softtabstop = 2
	vim.opt_local.expandtab = true
end)
