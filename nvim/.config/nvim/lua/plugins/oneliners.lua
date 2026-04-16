return {
	{ -- show CSS colors
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	{ -- git plugin
		"tpope/vim-fugitive",
	},
	{ -- lspconfig
		"neovim/nvim-lspconfig",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
}
