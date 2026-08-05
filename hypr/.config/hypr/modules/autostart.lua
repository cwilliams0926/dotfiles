---@module 'hl'
-- Nvidia-related env vars
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GL_VRR_ALLOWED", "0")

hl.env("AQ_MGPU_NO_EXPLICIT", "1")
hl.env("AQ_FORCE_LINEAR_BLIT", "0")

hl.env("HYPRCURSOR_THEME", "macOS-hypr")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "macOS")
hl.env("XCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Graphite-Dark")

hl.env("HYPRSHOT_DIR", "/home/cwilliams0926/Pictures/Screenshots/")

hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("sleep 1 && hyprpm reload -n")
	hl.exec_cmd("waybar & swaync & hypridle")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("sh -c 'sleep 0.5 && awww img \"$(cat ~/.cache/current-wallpaper)\"'")
	hl.exec_cmd("[workspace 1 silent] zen-browser")
	hl.exec_cmd("[workspace 2 silent] kitty")
end)
