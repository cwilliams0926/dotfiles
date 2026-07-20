---@module 'hl'

local mainMod = "SUPER"

hl.bind(mainMod .. " + " .. "return", hl.dsp.exec_cmd("kitty"))

hl.bind(mainMod .. " + " .. "C", hl.dsp.window.close())

hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + " .. "W", hl.dsp.exec_cmd("wlogout"))

hl.bind(mainMod .. " + " .. "V", hl.dsp.window.float())

hl.bind(mainMod .. " + " .. "space", hl.dsp.exec_cmd("rofi -show drun -display-drun"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "W", hl.dsp.exec_cmd("~/.config/custom_scripts/wallpaper-picker.sh"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("~/.config/custom_scripts/appearance-menu.sh"))

-- dwindle

hl.bind(mainMod .. " + " .. "r", hl.dsp.layout("togglesplit"))

-- dwindle

hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window"))

hl.bind("SHIFT" .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

hl.bind("CTRL" .. " + " .. "PRINT", hl.dsp.exec_cmd("hyprshot -m output"))

hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd("/home/cwilliams0926/.config/custom_scripts/wlsunset.sh"))

-- Move focus with mainMod + arrow keys

hl.bind(mainMod .. " + " .. "h", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + " .. "l", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + " .. "k", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + " .. "j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]

hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))

hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))

hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))

hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))

hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))

hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))

hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))

hl.bind(mainMod .. " + " .. 8, hl.dsp.focus({ workspace = 8 }))

hl.bind(mainMod .. " + " .. 9, hl.dsp.focus({ workspace = 9 }))

hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }))

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }))

-- Scroll through existing workspaces with mainMod + scroll

hl.bind(mainMod .. " + " .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + " .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

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

hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ "fullscreen", toggle }))

-- Float

hl.bind("SUPER + SHIFT + f", hl.dsp.window.float({ toggle }))

-- Move window

hl.bind(mainMod .. " + n", hl.dsp.window.swap({ next = true }))

-- Toggle waybar
hl.bind("SUPER + m", hl.dsp.exec_cmd("pkill waybar || waybar &"))

-- The "no fun" bind
hl.bind("SUPER + F1", function()
  local game_mode = (hl.get_config("animations.enabled") == false)
  hl.exec_cmd("pkill waybar && waybar -s ~/.config/waybar/minimal.css -c ~/.config/waybar/minimal-config.jsonc &")

  if game_mode then
    hl.exec_cmd("hyprctl reload")
    return
  end

  hl.config({
    general = {
      gaps_in = 0,
      gaps_out = 0, -- Disable gaps
      border_size = 2,
      ["col.active_border"] = "rgb(d3869b)",
      ["col.inactive_border"] = "rgb(1d2021)",
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

hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })   -- ALT + LMB: Move a window
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- ALT + RMB: Resize a window
