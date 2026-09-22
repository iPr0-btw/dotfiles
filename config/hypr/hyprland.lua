-- Setup
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XCURSOR_SIZE", "48")
hl.env("HYPRCURSOR_SIZE", "48")
hl.env("QT_QPA_PLATFORM", "wayland")

-- Monitors
local monitors = {
    { output = "eDP-1", mode = "2880x1800@120", pos = "0x0", scale = 2, bitdepth = 10 },
    { output = "eDP-2", mode = "2880x1800@120", pos = "0x0", scale = 2, bitdepth = 10, cm = "hdredid" },
    { output = "HDMI-A-1", mode = "1920x1080", pos = "0x-1080", scale = 1 },
}
for _, m in ipairs(monitors) do
    hl.monitor(m)
end

-- Apps
local apps = { terminal = "kitty -o linux_display_server=wayland", file = "thunar", menu = "caelestia shell drawers toggle launcher || rofi -show drun" }

-- Autostart
hl.on("hyprland.start", function()
    for _, cmd in ipairs({ "swaybg -i ~/wall0.png", "dms run || caelestia shell -d", "xrdb -merge ~/.Xresources" }) do
        hl.exec_cmd(cmd)
    end
end)

-- Curves
local curves = {
    easeOutQuint = { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } },
    easeInOutCubic = { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } },
    linear = { type = "bezier", points = { { 0, 0 }, { 1, 1 } } },
    almostLinear = { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } },
    quick = { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } },
}
for name, cfg in pairs(curves) do
    hl.curve(name, cfg)
end

-- Animations
local anims = {
    { leaf = "global", enabled = true, speed = 10, bezier = "default" },
    { leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" },
    { leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" },
    { leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" },
    { leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" },
    { leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" },
    { leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" },
    { leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" },
    { leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" },
    { leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" },
    { leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" },
    { leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" },
    { leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" },
    { leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" },
    { leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" },
    { leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" },
}
for _, a in ipairs(anims) do
    hl.animation(a)
end

-- Config
hl.config({
    general = {
        gaps_in = 0, gaps_out = 0, border_size = 0,
        col = { active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }, inactive_border = "rgba(595959aa)" },
        resize_on_border = true, allow_tearing = false, layout = "dwindle",
    },
    decoration = {
        rounding = 0, active_opacity = 1.0, inactive_opacity = 1.0,
        shadow = { enabled = true, range = 4, render_power = 3, color = 0xee1a1a1a },
        blur = { enabled = true, size = 3, passes = 1, vibrancy = 0.1696 },
    },
    animations = { enabled = true },
    dwindle = { preserve_split = true },
    master = { new_status = "master" },
    misc = { force_default_wallpaper = 1, disable_hyprland_logo = false, vrr = 1 },
    input = {
        kb_layout = "us", kb_variant = "", kb_model = "", kb_options = "", kb_rules = "",
        follow_mouse = 1, sensitivity = 0,
        touchpad = { natural_scroll = true },
    },
    xwayland = { force_zero_scaling = true },
})

-- Workspace rules
local ws_rules = { { ws = 5, layout = "scrolling", opts = { direction = "down" } }, { ws = 2, layout = "scrolling" }, { ws = 3, layout = "master" } }
for _, r in ipairs(ws_rules) do
    hl.workspace_rule({ workspace = r.ws, layout = r.layout, layout_opts = r.opts })
end

-- Keybinds
local mod = "ALT"
local binds = {
    -- Apps
    { mod .. " + Q", hl.dsp.exec_cmd(apps.terminal) },
    { mod .. " + B", hl.dsp.exec_cmd("librewolf") },
    { mod .. " + E", hl.dsp.exec_cmd(apps.file) },
    { mod .. " + SPACE", hl.dsp.exec_cmd(apps.menu) },
    -- Window
    { mod .. " + C", hl.dsp.window.close() },
    { mod .. " + V", hl.dsp.window.float({ action = "toggle" }) },
    { mod .. " + P", hl.dsp.window.pseudo() },
    { mod .. " + F", hl.dsp.window.fullscreen({ all = true }) },
    -- System
    { mod .. " + SHIFT + M", hl.dsp.exit() },
    { "CTRL + " .. mod .. " + DELETE", hl.dsp.exec_cmd("wlogout") },
    { "CTRL + " .. mod .. " + SHIFT + DELETE", hl.dsp.exec_cmd("reboot") },
    { mod .. " + TAB", hl.dsp.exec_cmd("snappy-switcher next") },
    { mod .. " + SHIFT + TAB", hl.dsp.exec_cmd("snappy-switcher prev") },
    -- Navigation
    { mod .. " + left", hl.dsp.focus({ direction = "left" }) },
    { mod .. " + right", hl.dsp.focus({ direction = "right" }) },
    { mod .. " + up", hl.dsp.focus({ direction = "up" }) },
    { mod .. " + down", hl.dsp.focus({ direction = "down" }) },
    -- Move
    { mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }) },
    { mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }) },
    { mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }) },
    { mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }) },
    -- Scroll workspaces
    { mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { mouse = true } },
    { mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { mouse = true } },
    -- Mouse drag/resize
    { mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true } },
    { mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true } },
    -- Media
    { "XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%+"), { locked = true, repeating = true } },
    { "XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%-"), { locked = true, repeating = true } },
    { "XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true } },
    { "XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true } },
    { "XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true } },
    { "XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true } },
    { "XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true } },
    { "XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true } },
    { "XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true } },
    { "XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true } },
    -- Special
    { "SUPER + S", hl.dsp.exec_cmd(".local/bin/screenshot") },
    { "SUPER + L", hl.dsp.exec_cmd("swaylock -c 000000") },
    { mod .. " + S", hl.dsp.workspace.toggle_special("magic") },
    { mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }) },
}

for i = 1, 10 do
    table.insert(binds, { mod .. " + " .. (i % 10), hl.dsp.focus({ workspace = i }) })
    table.insert(binds, { mod .. " + SHIFT + " .. (i % 10), hl.dsp.window.move({ workspace = i }) })
end

for _, b in ipairs(binds) do
    hl.bind(b[1], b[2], b[3])
end

-- Window rules
local win_rules = {
    { match = { class = ".*" }, suppress_event = "maximize" },
    { match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true },
    { match = { class = "^(osu!)$" }, workspace = "2 silent" },
    { match = { class = "^(librewolf)$" }, workspace = "1" },
    { match = { class = "^(steam)$" }, workspace = "4 silent" },
    { match = { class = "^(kitty)$" }, workspace = "3" },
}
for _, r in ipairs(win_rules) do
    hl.window_rule(r)
end
