local M = {}

M.themes = {
	["gruvbox-material"] = function()
		vim.o.background = "dark"
		vim.g.gruvbox_material_background = "soft"
		vim.g.gruvbox_material_transparent_background = 1
		vim.g.gruvbox_material_enable_bold = 1
		vim.g.gruvbox_material_enable_italic = 1
		vim.cmd.colorscheme("gruvbox-material")
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
	end,

	["catppuccin"] = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			styles = {
				comments = { "italic" },
				keywords = { "italic" },
				functions = { "bold" },
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,

	["everforest"] = function()
		vim.o.background = "dark"
		vim.g.everforest_background = "soft"
		vim.g.everforest_transparent_background = 1
		vim.g.everforest_enable_italic = 1
		vim.g.everforest_diagnostic_text_highlight = 1
		vim.g.everforest_diagnostic_virtual_text = "colored"
		vim.cmd.colorscheme("everforest")
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
	end,

	["gruvbox"] = function()
		vim.o.background = "dark"
		require("gruvbox").setup({
			contrast = "soft",
			transparent_mode = true,
			italic = {
				strings = true,
				comments = true,
				operators = false,
				folds = true,
			},
			bold = true,
		})
		vim.cmd.colorscheme("gruvbox")
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
	end,

	["rose-pine"] = function()
		require("rose-pine").setup({
			variant = "main",
			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},
		})
		vim.cmd.colorscheme("rose-pine")
	end,

	["e-ink"] = function()
		require("e-ink").setup()
		vim.opt.background = "light"
		vim.cmd.colorscheme("e-ink")
		local set_hl = vim.api.nvim_set_hl
		local mono = require("e-ink.palette").mono()
		set_hl(0, "Normal", { fg = mono[12], bg = "NONE" })
	end,

	["tokyonight"] = function()
		require("tokyonight").setup({
			style = "moon",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true, bold = true },
				functions = { bold = true },
				variables = {},
				sidebars = "transparent",
				floats = "transparent",
			},
		})
		vim.cmd.colorscheme("tokyonight")
	end,

	["kanagawa"] = function()
		require("kanagawa").setup({
			theme = "wave",
			transparent = true,
			dimInactive = true,
			terminalColors = true,
			colors = {
				theme = {
					wave = {
						ui = { bg_gutter = "none" },
					},
				},
			},
		})
		vim.cmd.colorscheme("kanagawa")
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
	end,
}

function M.apply(name)
	local fn = M.themes[name]
	if fn then
		fn()
	else
		vim.notify("Unknown theme: " .. tostring(name), vim.log.levels.WARN)
	end
end

return M
