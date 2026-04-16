-- lua/plugins/conform.lua
return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
            },

            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true, -- falls back to LSP formatting if no formatter is configured
            },
        })

        -- Manual format keymap
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({ async = true, lsp_fallback = true })
        end, { desc = "Conform: Format file" })
    end,
}
