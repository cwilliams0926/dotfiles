---@module 'hl'

local colors = require("colors.colors")

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 14,
    ["col.active_border"] = colors.bg2,
    ["col.inactive_border"] = colors.bg1,
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },
})

hl.config({
  decoration = {
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = {
      enabled = true,
      range = 28,
      render_power = 3,
      color = "rgba(0a0a0a89)",
    },
    blur = {
      enabled = true,
      size = 10,
      passes = 3,
      new_optimizations = true,
      noise = 0.01,
      contrast = 0.8,
      vibrancy = 0.2,
      xray = false,
      ignore_opacity = true,
    },
  },
})

hl.config({
  dwindle = {
    preserve_split = true,
    -- You probably want this
  },
})

hl.config({
  master = {
    new_status = "master",
  },
})

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },
})
