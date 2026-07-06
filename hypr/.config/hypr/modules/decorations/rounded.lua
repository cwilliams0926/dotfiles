---@module 'hl'

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 6,
    border_size = 1,
    ["col.active_border"] = "rgb(1d2021)",
    ["col.inactive_border"] = "rgb(1d2021)",
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },
})

hl.config({
  decoration = {
    rounding = 24,
    rounding_power = 8,
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
