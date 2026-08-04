vim.api.nvim_create_autocmd("Signal", {
	pattern = "SIGUSR1",
	group = vim.api.nvim_create_augroup("live_theme_reload", {}),
	callback = function()
		local theme = require("config.theme").current()
		require("config.themes").apply(theme)

		local ok, lualine = pcall(require, "lualine")
		if ok then
			lualine.setup(require("config.lualine_opts").build())
			lualine.refresh() -- forces immediate redraw, fixes stale separators/bg
		end

		vim.schedule(function()
			vim.cmd("redraw!")
		end)
	end,
})
