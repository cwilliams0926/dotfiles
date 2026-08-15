---@module 'hl'

local colors = require("colors.colors")

-- Open apps
hl.bind("SUPER + return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + e", hl.dsp.exec_cmd("nautilus"))
hl.bind("SUPER + w", hl.dsp.exec_cmd("wlogout -b 4 -c 0 -r 0 -m 300"))
hl.bind("SUPER + space", hl.dsp.exec_cmd("qs ipc call launcher toggle"))
hl.bind("SUPER + SHIFT + w", hl.dsp.exec_cmd("~/.config/custom_scripts/wallpaper-picker"))
hl.bind("SUPER + SHIFT + d", hl.dsp.exec_cmd("qs ipc call themePicker toggle"))
hl.bind("SUPER + m", hl.dsp.exec_cmd("qs kill || qs &"))
hl.bind("SUPER + ALT + r", hl.dsp.exec_cmd("swaync-client -R && swaync-client -rs"))
hl.bind("SUPER + SHIFT + n", hl.dsp.exec_cmd("swaync-client -t"))

-- Close apps
hl.bind("SUPER + c", hl.dsp.window.close())

-- Dwindle binds
hl.bind("SUPER + r", hl.dsp.layout("togglesplit"))

-- Hyprshot
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))

-- Toggle night light
hl.bind("SUPER + b", hl.dsp.exec_cmd("/home/cwilliams0926/.config/custom_scripts/wlsunset"))

-- Move focus with mainMod + arrow keys
hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Fullscreen
hl.bind("SUPER + f", hl.dsp.window.fullscreen({ "fullscreen", toggle }))

-- Float
hl.bind("SUPER + SHIFT + f", hl.dsp.window.float({ toggle }))

-- Move window
hl.bind("SUPER + n", hl.dsp.window.swap({ next = true }))

-- The "no fun" bind
hl.bind("SUPER + F1", function()
	local game_mode = (hl.get_config("animations.enabled") == false)
	hl.exec_cmd("pkill waybar || waybar")

	if game_mode then
		hl.exec_cmd("hyprctl reload")
		return
	end

	if hl.plugin.hyprglass then
		hl.plugin.hyprglass.config({ enabled = false })
	end

	hl.config({
		general = {
			gaps_in = 0,
			gaps_out = 0, -- Disable gaps
			border_size = 2,
			["col.active_border"] = colors.purple,
			["col.inactive_border"] = colors.bg2,
		},

		animations = {
			enabled = false, -- Disable animations
		},

		-- Disable blur, shadow and window rounding
		decoration = {
			shadow = { enabled = false },
			blur = { enabled = false },
			rounding = 0,
		},
	})
end)

-- Mouse resizing and moving
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- ALT + LMB: Move a window
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- ALT + RMB: Resize a window

-- Change split ratio
hl.bind("SUPER + SHIFT + l", hl.dsp.layout("splitratio +0.1"))
hl.bind("SUPER + SHIFT + h", hl.dsp.layout("splitratio -0.1"))
