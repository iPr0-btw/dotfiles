-- Hyprland Lua Config
-- https://wiki.hypr.land/Configuring/Start/

-- ---------------------------------------------------------------------------
-- MONITORS
-- ---------------------------------------------------------------------------

for _, m in ipairs({
    { output = "eDP-1", mode = "2880x1800@120", position = "0x0", scale = 2, bitdepth = 10 },
    { output = "eDP-2", mode = "2880x1800@120", position = "0x0", scale = 2, bitdepth = 10, cm = "hdredid" },
    { output = "HDMI-A-1", mode = "1920x1080", position = "0x-1080", scale = 1 },
}) do hl.monitor(m) end

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

-- ---------------------------------------------------------------------------
-- AUTOSTART
-- ---------------------------------------------------------------------------

hl.on("hyprland.start", function()
    for _, cmd in ipairs({ "swaybg -i ~/wall0.png", "dms run || caelestia shell -d", "xrdb -merge ~/.Xresources" }) do
        hl.exec_cmd(cmd)
    end
end)

-- ---------------------------------------------------------------------------
-- CONFIG
-- ---------------------------------------------------------------------------

for k, v in pairs({ XCURSOR_SIZE = "48", HYPRCURSOR_SIZE = "48", QT_QPA_PLATFORM = "wayland" }) do hl.env(k, v) end

hl.config({
    general = { gaps_in = 0, gaps_out = 0, border_size = 0, layout = "dwindle", resize_on_border = true, allow_tearing = false,
        col = { active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }, inactive_border = "rgba(595959aa)" } },
    decoration = { rounding = 0, active_opacity = 1, inactive_opacity = 1,
        shadow = { enabled = true, range = 4, render_power = 3, color = 0xee1a1a1a },
        blur = { enabled = true, size = 3, passes = 1, vibrancy = 0.1696 } },
    animations = { enabled = true }, dwindle = { preserve_split = true }, master = { new_status = "master" },
    misc = { force_default_wallpaper = 1, disable_hyprland_logo = false, vrr = 1 },
    input = { kb_layout = "us", kb_variant = "", kb_model = "", kb_options = "", kb_rules = "",
        follow_mouse = 1, sensitivity = 0, touchpad = { natural_scroll = true } },
    xwayland = { force_zero_scaling = true },
})

for name, pts in pairs({
    easeOutQuint = { { 0.23, 1 }, { 0.32, 1 } }, easeInOutCubic = { { 0.65, 0.05 }, { 0.36, 1 } },
    linear = { { 0, 0 }, { 1, 1 } }, almostLinear = { { 0.5, 0.5 }, { 0.75, 1 } }, quick = { { 0.15, 0 }, { 0.1, 1 } },
}) do hl.curve(name, { type = "bezier", points = pts }) end

for _, a in ipairs({
    { "global", 10, "default" }, { "border", 5.39, "easeOutQuint" }, { "windows", 4.79, "easeOutQuint" },
    { "windowsIn", 4.1, "easeOutQuint", "popin 87%" }, { "windowsOut", 1.49, "linear", "popin 87%" },
    { "fadeIn", 1.73, "almostLinear" }, { "fadeOut", 1.46, "almostLinear" }, { "fade", 3.03, "quick" },
    { "layers", 3.81, "easeOutQuint" }, { "layersIn", 4, "easeOutQuint", "fade" }, { "layersOut", 1.5, "linear", "fade" },
    { "fadeLayersIn", 1.79, "almostLinear" }, { "fadeLayersOut", 1.39, "almostLinear" },
    { "workspaces", 1.94, "almostLinear", "fade" }, { "workspacesIn", 1.21, "almostLinear", "fade" }, { "workspacesOut", 1.94, "almostLinear", "fade" },
}) do
    local cfg = { leaf = a[1], enabled = true, speed = a[2], bezier = a[3] }
    if a[4] then cfg.style = a[4] end
    hl.animation(cfg)
end

-- ---------------------------------------------------------------------------
-- KEYBINDINGS
-- ---------------------------------------------------------------------------

local term, fm, menu = "kitty -o linux_display_server=wayland", "thunar", "caelestia shell drawers toggle launcher || rofi -show drun"
local m, mk = "ALT", function(k, c, o) hl.bind(m .. " + " .. k, c, o) end
local me = function(k, c, o) hl.bind(m .. " + " .. k, hl.dsp.exec_cmd(c), o) end
local mm = function(k, c, o) hl.bind(k, hl.dsp.exec_cmd(c), o) end

for k, c in pairs({ Q = term, B = "librewolf", E = fm, SPACE = menu }) do me(k, c) end
for k, c in pairs({ C = hl.dsp.window.close(), V = hl.dsp.window.float({ action = "toggle" }),
    P = hl.dsp.window.pseudo(), F = hl.dsp.window.fullscreen({ all = true }) }) do mk(k, c) end

mk("SHIFT + M", hl.dsp.exit())
hl.bind("CTRL + " .. m .. " + DELETE", hl.dsp.exec_cmd("wlogout"))
hl.bind("CTRL + " .. m .. " + SHIFT + DELETE", hl.dsp.exec_cmd("reboot"))

me("TAB", "snappy-switcher next")
me("SHIFT + TAB", "snappy-switcher prev")

for _, d in ipairs({ "left", "right", "up", "down" }) do
    mk(d, hl.dsp.focus({ direction = d }))
    mk("SHIFT + " .. d, hl.dsp.window.move({ direction = d }))
end

for i = 1, 10 do
    local key = i == 10 and "0" or tostring(i)
    mk(key, hl.dsp.focus({ workspace = i }))
    mk("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

mk("S", hl.dsp.workspace.toggle_special("magic"))
mk("SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
mk("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
mk("mouse_up", hl.dsp.focus({ workspace = "e-1" }))
mk("mouse:272", hl.dsp.window.drag(), { mouse = true })
mk("mouse:273", hl.dsp.window.resize(), { mouse = true })

for k, c in pairs({
    XF86AudioRaiseVolume = { "wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%+", { locked = true, repeating = true } },
    XF86AudioLowerVolume = { "wpctl set-volume @DEFAULT_SINK@ 4%-", { locked = true, repeating = true } },
    XF86AudioMute = { "wpctl set-mute @DEFAULT_SINK@ toggle", { locked = true } },
    XF86AudioMicMute = { "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", { locked = true } },
    XF86MonBrightnessUp = { "brightnessctl s 10%+", { locked = true, repeating = true } },
    XF86MonBrightnessDown = { "brightnessctl s 10%-", { locked = true, repeating = true } },
    XF86AudioNext = { "playerctl next", { locked = true } }, XF86AudioPause = { "playerctl play-pause", { locked = true } },
    XF86AudioPlay = { "playerctl play-pause", { locked = true } }, XF86AudioPrev = { "playerctl previous", { locked = true } },
}) do mm(k, c[1], c[2]) end

hl.bind("SUPER + S", hl.dsp.exec_cmd(".local/bin/screenshot"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("swaylock -c 000000"))

-- ---------------------------------------------------------------------------
-- WINDOW RULES
-- ---------------------------------------------------------------------------

for _, r in ipairs({
    { "suppress-maximize-events", { class = ".*" }, suppress_event = "maximize" },
    { "fix-xwayland-drags", { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true },
    { "osu", { class = "^(osu!)$" }, workspace = "2 silent" }, { "librewolf", { class = "^(librewolf)$" }, workspace = "1" },
    { "steam", { class = "^(steam)$" }, workspace = "4 silent" }, { "kitty", { class = "^(kitty)$" }, workspace = "3" },
}) do hl.window_rule({ name = r[1], match = r[2], suppress_event = r.suppress_event, no_focus = r.no_focus, workspace = r.workspace }) end

require("hyprland-gui")
