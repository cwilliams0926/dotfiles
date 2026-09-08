return {
  "nvim-telescope/telescope.nvim",
  version = "0.2.2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_config = {
          horizontal = {
            preview_cutoff = 100,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Adds hidden files to grep searches
          "--no-ignore", -- ignores .gitignore rules
        },
      },
    })
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find git files" })
    vim.keymap.set("n", "<leader>ph", function()
      require("telescope.builtin").find_files({ hidden = true })
    end, { desc = "Telescope find files including hidden" })
  end,
}
