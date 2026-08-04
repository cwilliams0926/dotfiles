local theme = require("config.theme").current()
local themes = require("config.themes")

return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			if theme == "gruvbox-material" then
				themes.apply("gruvbox-material")
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			if theme == "catppuccin" then
				themes.apply("catppuccin")
			end
		end,
	},
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			if theme == "everforest" then
				themes.apply("everforest")
			end
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			if theme == "gruvbox" then
				themes.apply("gruvbox")
			end
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			if theme == "rose-pine" then
				themes.apply("rose-pine")
			end
		end,
	},
	{
		"e-ink-colorscheme/e-ink.nvim",
		name = "e-ink",
		lazy = false,
		priority = 1000,
		config = function()
			if theme == "e-ink" then
				themes.apply("e-ink")
			end
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = false,
		priority = 1000,
		config = function()
			if theme == "tokyonight" then
				themes.apply("tokyonight")
			end
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			if theme == "kanagawa" then
				themes.apply("kanagawa")
			end
		end,
	},
}
