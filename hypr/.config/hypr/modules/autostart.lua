---@module 'hl'

hl.env("HYPRCURSOR_THEME", "macOS-hypr")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "macOS")
hl.env("XCURSOR_SIZE", "24")

hl.env("HYPRSHOT_DIR", "/home/cwilliams0926/Pictures/Screenshots/")

-- Autostart
hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("waybar & swaync & hypridle")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("sh -c 'sleep 0.5 && awww img \"$(cat ~/.cache/current-wallpaper)\"'")
  hl.exec_cmd("wlsunset -l 39.6 -L -79.9 -t 3200 -T 6500")
  hl.exec_cmd("[workspace 1 silent] zen-browser")
  hl.exec_cmd("[workspace 2 silent] kitty")
end)
