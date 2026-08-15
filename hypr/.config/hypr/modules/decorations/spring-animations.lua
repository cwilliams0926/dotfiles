hl.config({
	animations = {
		enabled = true,

		-- Expressive: windows appearing, special workspace
		hl.curve("spring_open", {
			type = "spring",
			mass = 1,
			stiffness = 250,
			dampening = 25,
		}),

		-- Responsive: movement and closing
		hl.curve("spring_snappy", {
			type = "spring",
			mass = 1,
			stiffness = 400,
			dampening = 38,
		}),

		-- Controlled: workspaces, fades, general UI
		hl.curve("spring_smooth", {
			type = "spring",
			mass = 1,
			stiffness = 420,
			dampening = 45,
		}),

		-- Windows
		hl.animation({
			leaf = "windows",
			enabled = true,
			speed = 5,
			spring = "spring_open",
			style = "popin 90%",
		}),

		hl.animation({
			leaf = "windowsIn",
			enabled = true,
			speed = 5,
			spring = "spring_open",
			style = "popin 90%",
		}),

		hl.animation({
			leaf = "windowsOut",
			enabled = true,
			speed = 5,
			spring = "spring_snappy",
			style = "popin 95%",
		}),

		hl.animation({
			leaf = "windowsMove",
			enabled = true,
			speed = 4,
			spring = "spring_snappy",
		}),

		-- Layers
		hl.animation({
			leaf = "layersIn",
			enabled = true,
			speed = 4,
			spring = "spring_open",
		}),

		hl.animation({
			leaf = "layersOut",
			enabled = true,
			speed = 4,
			spring = "spring_snappy",
		}),

		-- Fades
		hl.animation({
			leaf = "fade",
			enabled = true,
			speed = 4,
			spring = "spring_smooth",
		}),

		hl.animation({
			leaf = "fadeOut",
			enabled = true,
			speed = 4,
			spring = "spring_smooth",
		}),

		hl.animation({
			leaf = "fadeLayers",
			enabled = true,
			speed = 4,
			spring = "spring_smooth",
		}),

		-- Workspaces
		hl.animation({
			leaf = "workspaces",
			enabled = true,
			speed = 5,
			spring = "spring_smooth",
			style = "slide",
		}),
		hl.animation({
			leaf = "specialWorkspace",
			enabled = true,
			speed = 5,
			spring = "spring_open",
			style = "slidefadevert 30%",
		}),
	},
})
