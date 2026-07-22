---@module 'hl'

local colors = require("colors.colors")

hl.config({
	general = {
		border_size = 2,
		["col.active_border"] = colors.grey0,
		["col.inactive_border"] = colors.bg1,
	},
})

hl.config({
	decoration = {
		rounding = 0,
	},
})
