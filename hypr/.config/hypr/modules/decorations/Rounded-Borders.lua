---@module 'hl'

local colors = require("colors.colors")

hl.config({
  general = {
    border_size = 2,
    ["col.active_border"] = colors.pink,
    ["col.inactive_border"] = colors.bg5,
  },
})

hl.config({
  decoration = {
    rounding = 20,
  },
})
