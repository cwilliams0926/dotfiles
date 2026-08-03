---@module 'hl'

hl.window_rule({
	name = "suppress-maximize-events",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Hyprland-run windowrule

hl.window_rule({
	name = "move-hyprland-run",
	match = {
		class = "hyprland-run",
	},
	move = { 20, "monitor_h-120" },
	float = true,
})

hl.workspace_rule({
	workspace = 1,
	monitor = "eDP-1",
})

hl.workspace_rule({
	workspace = 2,
	monitor = "eDP-1",
})

hl.workspace_rule({
	workspace = 3,
	monitor = "eDP-1",
})

hl.workspace_rule({
	workspace = 4,
	monitor = "eDP-1",
})

hl.layer_rule({
	match = {
		namespace = "waybar",
	},
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	match = {
		namespace = "^rofi$",
	},
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	match = {
		namespace = "swaync-control-center",
	},
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	match = {
		namespace = "swaync-notification-window",
	},
	ignore_alpha = 0,
})

hl.layer_rule({
	match = {
		namespace = "logout_dialog",
	},
	blur = true,
	ignore_alpha = 0,
})
