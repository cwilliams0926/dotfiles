---@module 'hl'

local colors = require("colors.colors")

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 14,
		["col.active_border"] = colors.bg1,
		["col.inactive_border"] = colors.bg2,
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
			size = 13,
			passes = 2,
			brightness = 0.8,
			noise = 0,
			contrast = 2,
			vibrancy = 0.35,
			vibrancy_darkness = 0.35,
			special = false,
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
