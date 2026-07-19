local theme = require("config.theme").current()

return {
  {
    "sainnhe/gruvbox-material",
    cond = theme == "gruvbox-material",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.cmd.colorscheme("gruvbox-material")
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    cond = theme == "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- dark variant
        transparent_background = true,
        styles = {
          comments = { "italic" },
          keywords = { "italic" },
          functions = { "bold" },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "sainnhe/everforest",
    cond = theme == "everforest",
    priority = 1000,
    config = function()
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
  },

  {
    "ellisonleao/gruvbox.nvim",
    cond = theme == "gruvbox",
    priority = 1000,
    config = function()
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
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    cond = theme == "rosepine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- dark variant ("main", "moon", "dawn" is the light one)
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
      vim.cmd.colorscheme("rose-pine")
    end,
  },
}
