return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      local cmds = {
        "let g:gruvbox_material_background = 'soft'",
        "let g:gruvbox_material_transparent_background = 1",
        "let g:gruvbox_material_diagnostic_line_highlight = 1",
        "let g:gruvbox_material_diagnostic_virtual_text = 'colored'",
        "let g:gruvbox_material_enable_bold = 1",
        "let g:gruvbox_material_enable_italic = 1",
        "colorscheme gruvbox-material",
      }
      for _, cmd in ipairs(cmds) do
        vim.cmd(cmd)
      end
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local custom_theme = require("lualine.themes.gruvbox-material")

      for _, mode in pairs(custom_theme) do
        if mode.c then
          mode.c.bg = "none"
        end
      end

      return {
        options = {
          theme = custom_theme,
          section_separators = { left = "", right = "" },
          component_separators = "",
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { "filename", "branch", "diff" },
          lualine_c = {
            "%=", --[[ add your center components here in place of this comment ]]
          },
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
}
