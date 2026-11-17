local host = require("host")
if host then
	require(host)
end

--##################
--## MY PROGRAMS ###
--##################

local bar = "waybar"
local terminal = "kitty"
local menu = "rofi -show drun"
local dmenu = "rofi -dmenu"
local browser = "firefox"
local idle = "hypridle"
local widget = "eww daemon"

--#############
--## EVENTS ###
--#############

hl.on("hyprland.start", function()
	hl.exec_cmd(bar)
	hl.exec_cmd("dunst")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd(terminal, { workspace = "1 silent" })
	hl.exec_cmd(browser, { workspace = "2 silent" })
	hl.exec_cmd("discord")
	hl.exec_cmd("fractal", { workspace = "3 silent" })
	hl.exec_cmd("spotify-launcher", { workspace = "4 silent" })
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd(idle)
	hl.exec_cmd(widget)
end)

hl.on("layer.closed", function(layer)
	if layer.namespace == "eww-media" then
		hl.dispatch(hl.dsp.submap("reset"))
	end
end)

--############################
--## ENVIRONMENT VARIABLES ###
--############################

hl.env("XCURSOR_SIZE", "28")
hl.env("HYPRCURSOR_SIZE", "28")
hl.env("EDITOR", "nvim")
hl.env("GTK_THEME", "Dracula:dark")

--####################
--## LOOK AND FEEL ###
--####################

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,
		border_size = 1,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},

	--############
	--## INPUT ###
	--############

	input = {
		kb_layout = "us,rs",
		kb_variant = ",latin",
		kb_model = "",
		kb_options = "grp:alt_space_toggle",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({
	leaf = "global",
	enabled = true,
	speed = 10,
	bezier = "default",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5.39,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 4.79,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4.1,
	bezier = "easeOutQuint",
	style = "popin 87%",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 1.49,
	bezier = "linear",
	style = "popin 87%",
})
hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 1.73,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 1.46,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 3.03,
	bezier = "quick",
})
hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 3.81,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 4,
	bezier = "easeOutQuint",
	style = "fade",
})
hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 1.5,
	bezier = "linear",
	style = "fade",
})
hl.animation({
	leaf = "fadeLayersIn",
	enabled = true,
	speed = 1.79,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fadeLayersOut",
	enabled = true,
	speed = 1.39,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 1,
	bezier = "almostLinear",
	style = "slide",
})
hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 3,
	bezier = "almostLinear",
	style = "fade",
})

--##################
--## KEYBINDINGS ###
--##################

local function ubind(keys, dsp, opts)
	opts = opts or {}
	opts.submap_universal = true
	hl.bind(keys, dsp, opts)
end

local function cursor_over_media()
	local c = hl.get_cursor_pos()
	for _, l in ipairs(hl.get_layers()) do
		if l.namespace == "eww-media" then
			return c.x >= l.x and c.x <= l.x + l.w and c.y >= l.y and c.y <= l.y + l.h
		end
	end
	return false
end

local mainMod = "ALT"

ubind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
ubind(mainMod .. " + C", hl.dsp.window.close())
ubind(mainMod .. " + SHIFT + M", hl.dsp.exit())
ubind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
ubind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
ubind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

ubind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
ubind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
ubind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
ubind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

ubind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
ubind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
ubind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
ubind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
ubind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
ubind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
ubind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
ubind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
ubind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
ubind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

ubind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
ubind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
ubind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
ubind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
ubind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
ubind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
ubind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
ubind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
ubind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
ubind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

ubind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
ubind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))
ubind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
ubind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))

ubind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
ubind(mainMod .. " + SHIFT + S", function()
	hl.dispatch(hl.dsp.window.move({ workspace = "special:magic" }))
	if not cursor_over_media() then
		hl.dispatch(hl.dsp.submap("reset"))
	end
end)

ubind(mainMod .. " + mouse:272", hl.dsp.window.drag())
ubind(mainMod .. " + mouse:273", hl.dsp.window.resize())

ubind(mainMod .. " + M", hl.dsp.exec_cmd("eww open --toggle media"))
ubind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
ubind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
ubind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
ubind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

local run_script = require("lib/script")

ubind(mainMod .. " + w", run_script("relaunch_waybar.sh"))

ubind(mainMod .. " + CTRL + s", run_script("screenshot.sh", { dmenu }))

hl.define_submap("media", function()
	hl.bind("left", hl.dsp.exec_cmd("playerctl position 5-"), { repeating = true })
	hl.bind("right", hl.dsp.exec_cmd("playerctl position 5+"), { repeating = true })
	hl.bind("space", hl.dsp.exec_cmd("playerctl play-pause"), { repeating = true })
end)

--#############################
--## WINDOWS AND WORKSPACES ###
--#############################

hl.window_rule({
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	match = {
		class = "^$",
		title = "^$",
		xwayland = 1,
		float = 1,
		fullscreen = 0,
		pin = 0,
	},
	no_focus = true,
})

hl.window_rule({ name = "discord", match = { class = "^(discord)$" }, workspace = "3 silent" })
