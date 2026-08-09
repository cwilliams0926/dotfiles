---@module 'hl'

local colors = require("colors.colors")

if hl.plugin.hyprglass then
	local hg = hl.plugin.hyprglass

	local function tint(c, alpha)
		return tonumber(c:match("%x%x%x%x%x%x"), 16) * 256 + math.floor(alpha * 255 + 0.5)
	end

	hg.config({
		default_theme = "dark",
		default_preset = "apple",

		light = { adaptive_boost = 0.5 },

		layers = { enabled = 1 },
	})

	-- Layer surfaces: each call whitelists the namespace and configures it
	hg.layer("waybar", { exclude = true })
	hg.layer("swaync", { exclude = true })
	hg.layer("^(zen)$")
	hg.layer("rofi", { exclude = true })
	hg.layer("quickshell:bezel", { preset = "ui", mask_threshold = 0.3 })
	hg.layer("debug-panel", { exclude = true })

	hl.window_rule({ match = { class = "mpv" }, tag = "+hyprglass_disabled" })
	hl.window_rule({ match = { class = "fullscreen = true" }, tag = "+hyprglass_disabled" })

	-- Presets
	hg.preset("clear", {
		glass_opacity = 0.8,
		blur_strength = 2,
		dark = { brightness = 0.7 },
		light = { brightness = 1.2 },
	})

	hg.preset("contrasted", {
		inherits = "high_contrast",
		contrast = 1.2,
		adaptive_dim = 1.5,
		dark = { tint_color = 0x02142aa9 },
	})

	hg.preset("glass", {
		blur_strength = 1.0,
		blur_iterations = 3,
		chromatic_aberration = 0.8,
		fresnel_strength = 0.8,
		edge_thickness = 0.08,
		tint_color = tint(colors.bg0, 0.12),
		lens_distortion = 0.9,
		brightness = 1.0,
		contrast = 1.7,
		saturation = 1,
		vibrancy = 0.8,
		vibrancy_darkness = 1,
		adaptive_boost = 0.5,
	})

	hg.preset("apple", {
		blur_strength = 1.2,
		blur_iterations = 2,
		refraction_strength = 0.75,
		chromatic_aberration = 0.28,
		fresnel_strength = 0.9,
		specular_strength = 1.2,
		edge_thickness = 0.12,
		lens_distortion = 0.6,
		dark = { brightness = 1, contrast = 1.08, saturation = 1.05, vibrancy = 0.35, adaptive_dim = 0 },
		light = { brightness = 1.05, contrast = 1.06, saturation = 1.08, vibrancy = 0.3, adaptive_dim = 0.15 },
	})
end
