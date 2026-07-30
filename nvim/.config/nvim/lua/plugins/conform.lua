-- lua/plugins/conform.lua
return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettier", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				qml = { "qmlformat" },
			},

			formatters = {
				qmlformat = {
					command = "/usr/lib/qt6/bin/qmlformat",
					args = { "-w", "2", "-i", "$FILENAME" },
					stdin = false,
				},
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false, -- falls back to LSP formatting if no formatter is configured
			},
		})

		-- Manual format keymap
		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({ async = true, lsp_fallback = true })
		end, { desc = "Conform: Format file" })
	end,
}
