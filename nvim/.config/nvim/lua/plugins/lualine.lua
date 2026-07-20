return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local theme = require("config.theme").current()
    local ok, lualine_theme = pcall(require, "lualine.themes." .. theme)
    if not ok then
      lualine_theme = "auto"
    end

    if type(lualine_theme) == "table" then
      for _, mode in pairs(lualine_theme) do
        if mode.c then
          mode.c.bg = "none"
        end
      end
    end

    return {
      options = {
        theme = lualine_theme,
        section_separators = { left = "", right = "" },
        component_separators = "",
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch", "diff" },
        lualine_c = { "%=" },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
    }
  end,
}
