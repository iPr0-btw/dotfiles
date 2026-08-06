-- a boring hyprland lua config.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@120",
	position = "0x0",
	scale = 2,
	bitdepth = 10,
	cm = "hdredid",
})

hl.monitor({
	output = "eDP-2",
	mode = "2880x1800@120",
	position = "0x0",
	scale = 2,
	bitdepth = 10,
	cm = "hdredid",
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080",
	position = "0x-1080",
	scale = 1,
})

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty -o linux_display_server=wayland"
local fileManager = "thunar"
local menu = "dms ipc call spotlight-bar open"
-- local menu = "rofi -show drun" --uncomment if you use this
-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet &")
	hl.exec_cmd("swaybg -i ~/wall0.png")
	hl.exec_cmd("dunst &")
	hl.exec_cmd("dms run &")
	hl.exec_cmd("sleep 1 && hyprpaper")
	-- hl.exec_cmd("hypridle")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "48")
hl.env("HYPRCURSOR_SIZE", "48")
-- hl.env("DRI_PRIME", "0") -- for dual GPU laptops
hl.env("QT_QPA_PLATFORM", "wayland")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,

		border_size = 0,

		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
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
})

-- Bezier curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Workspace rules
hl.workspace_rule({ workspace = 5, layout = "scrolling", layout_opts = { direction = "down" } })
hl.workspace_rule({ workspace = 2, layout = "scrolling" })
hl.workspace_rule({ workspace = "special:magic", layout = "master" })
hl.workspace_rule({ workspace = 3, layout = "master" })
hl.workspace_rule({ workspace = 2, layout = "lua:grid" })
require("grid")

-- Layout configuration
hl.config({
	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = false,
		vrr = 1,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
		},
	},
})

-- Per-device config

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT" -- Sets "Alt" key as main modifier

-- Application launches
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("librewolf"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("kill -9 $(hyprctl activewindow -j | jq -r '.pid')"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + ENTER", hl.dsp.window.fullscreen({ all = false }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ all = true }))

-- System
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind("CTRL + " .. mainMod .. " + DELETE", hl.dsp.exec_cmd("wlogout"))
hl.bind("CTRL + " .. mainMod .. " + SHIFT + DELETE", hl.dsp.exec_cmd("reboot"))

-- Window switching
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("snappy-switcher next"))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.exec_cmd("snappy-switcher prev"))

-- Focus navigation
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Workspace switching (1-9)
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Workspace 10 (0 key)
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Player controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Hyprshot screenshots
hl.bind("SUPER + S", hl.dsp.exec_cmd("hyprshot -m region"))

-- Lock screen
hl.bind("SUPER + L", hl.dsp.exec_cmd("swaylock -c 000000"))
-- hl.bind("SUPER + L", hl.dsp.exec_cmd("dms ipc lock lock"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Suppress maximize events
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix XWayland dragging issues
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

hl.window_rule({
	name = "osu on workspace 2",
	match = { class = "^(osu!)$" },
	workspace = "2 silent",
})

hl.window_rule({
	name = "librewolf on workspace 1",
	match = { class = "^(librewolf)$" },
	workspace = "1",
})

hl.window_rule({
	name = "kitty on workspace 3",
	match = { class = "^(kitty)$" },
	workspace = "3",
})
-----------------------
----- XWAYLAND -----
-----------------------

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

-------------------
----- DPI -----
-------------------

-- DPI setting (note: this may need to be set via monitor config or display settings)
-- hl.config({ misc = { dpi = 207 } })
