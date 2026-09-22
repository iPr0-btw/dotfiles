-- Hyprland Configuration (DRY refactored)
-- https://wiki.hypr.land/Configuring/Start/

--------------------------------------------------------------------------------
-- HELPER FUNCTIONS
--------------------------------------------------------------------------------

--- Create a helper for common bind patterns
local function bind(mod, key, action, opts)
    opts = opts or {}
    hl.bind(mod .. " + " .. key, action, opts)
end

--- Helper for application keybinds
local function app_bind(mod, key, app)
    bind(mod, key, hl.dsp.exec_cmd(app))
end

--- Helper for window management binds
local function window_bind(mod, key, action)
    bind(mod, key, hl.dsp.window[action.func](action.opts or {}))
end

--- Helper for focus navigation
local function focus_bind(mod, key, direction)
    bind(mod, key, hl.dsp.focus({ direction = direction }))
end

--- Helper for window movement
local function move_bind(mod, key, direction)
    bind(mod, key, hl.dsp.window.move({ direction = direction }))
end

--- Helper for workspace navigation
local function workspace_bind(mod, key, workspace)
    bind(mod, key, hl.dsp.focus({ workspace = workspace }))
end

--- Helper for workspace movement
local function workspace_move_bind(mod, key, workspace)
    bind(mod, key, hl.dsp.window.move({ workspace = workspace }))
end

--- Helper to assign windows to workspaces
local function assign_to_workspace(class, workspace, silent)
    silent = silent ~= false  -- default to true
    hl.window_rule({
        name = class .. " → workspace " .. workspace,
        match = { class = "^(" .. class .. ")$" },
        workspace = tostring(workspace) .. (silent and " silent" or ""),
    })
end

--- Helper to create env variables from table
local function set_env_vars(vars)
    for key, value in pairs(vars) do
        hl.env(key, value)
    end
end

--- Helper to setup monitors from table
local function setup_monitors(monitors_table)
    for _, monitor in ipairs(monitors_table) do
        hl.monitor(monitor)
    end
end

--- Helper to create animation curves
local function create_curves(curves_table)
    for name, curve_data in pairs(curves_table) do
        hl.curve(name, curve_data)
    end
end

--- Helper to setup animations from table
local function setup_animations(animations_table)
    for _, anim in ipairs(animations_table) do
        anim.enabled = true
        hl.animation(anim)
    end
end

--- Helper to setup window rules in batch
local function setup_window_rules(rules_table)
    for _, rule in ipairs(rules_table) do
        hl.window_rule(rule)
    end
end

--------------------------------------------------------------------------------
-- CONFIGURATION DATA
--------------------------------------------------------------------------------

--- Monitor configuration
local monitors = {
    {
        output = "eDP-1",
        mode = "2880x1800@120",
        position = "0x0",
        scale = 2,
        bitdepth = 10,
    },
    {
        output = "eDP-2",
        mode = "2880x1800@120",
        position = "0x0",
        scale = 2,
        bitdepth = 10,
        cm = "hdredid",
    },
    {
        output = "HDMI-A-1",
        mode = "1920x1080",
        position = "0x-1080",
        scale = 1,
    },
}

--- Programs
local apps = {
    terminal = "kitty -o linux_display_server=wayland",
    fileManager = "thunar",
    menu = "caelestia shell drawers toggle launcher || rofi -show drun",
    browser = "librewolf",
    screenshot = ".local/bin/screenshot",
}

--- Environment variables
local env_vars = {
    XDG_CURRENT_DESKTOP = "Hyprland",
    XCURSOR_SIZE = "48",
    HYPRCURSOR_SIZE = "48",
    QT_QPA_PLATFORM = "wayland",
}

--- Bezier curves for animations
local curves = {
    easeOutQuint = { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } },
    easeInOutCubic = { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } },
    linear = { type = "bezier", points = { { 0, 0 }, { 1, 1 } } },
    almostLinear = { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } },
    quick = { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } },
}

--- Animation configurations
local animations = {
    { leaf = "global", speed = 10, bezier = "default" },
    { leaf = "border", speed = 5.39, bezier = "easeOutQuint" },
    { leaf = "windows", speed = 4.79, bezier = "easeOutQuint" },
    { leaf = "windowsIn", speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" },
    { leaf = "windowsOut", speed = 1.49, bezier = "linear", style = "popin 87%" },
    { leaf = "fadeIn", speed = 1.73, bezier = "almostLinear" },
    { leaf = "fadeOut", speed = 1.46, bezier = "almostLinear" },
    { leaf = "fade", speed = 3.03, bezier = "quick" },
    { leaf = "layers", speed = 3.81, bezier = "easeOutQuint" },
    { leaf = "layersIn", speed = 4, bezier = "easeOutQuint", style = "fade" },
    { leaf = "layersOut", speed = 1.5, bezier = "linear", style = "fade" },
    { leaf = "fadeLayersIn", speed = 1.79, bezier = "almostLinear" },
    { leaf = "fadeLayersOut", speed = 1.39, bezier = "almostLinear" },
    { leaf = "workspaces", speed = 1.94, bezier = "almostLinear", style = "fade" },
    { leaf = "workspacesIn", speed = 1.21, bezier = "almostLinear", style = "fade" },
    { leaf = "workspacesOut", speed = 1.94, bezier = "almostLinear", style = "fade" },
}

--- Workspace layout rules
local workspace_rules = {
    { workspace = 5, layout = "scrolling", layout_opts = { direction = "down" } },
    { workspace = 2, layout = "scrolling" },
    { workspace = 3, layout = "master" },
    { workspace = "special:magic", layout = "master" },
}

--- Application to workspace assignments
local app_assignments = {
    { class = "osu!", workspace = 2 },
    { class = "librewolf", workspace = 1, silent = false },
    { class = "steam", workspace = 4 },
    { class = "kitty", workspace = 3, silent = false },
}

--- Custom window rules
local window_rules = {
    {
        name = "suppress-maximize-events",
        match = { class = ".*" },
        suppress_event = "maximize",
    },
    {
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
    },
}

--- Keybind configurations
local keybinds = {
    -- App launches
    apps = {
        { mod = "ALT", key = "Q", app = "terminal" },
        { mod = "ALT", key = "B", app = "browser" },
        { mod = "ALT", key = "E", app = "fileManager" },
        { mod = "ALT", key = "SPACE", app = "menu" },
    },
    -- Window management
    windows = {
        { mod = "ALT", key = "C", action = "close" },
        { mod = "ALT", key = "V", action = "float", opts = { action = "toggle" } },
        { mod = "ALT", key = "P", action = "pseudo" },
        { mod = "ALT", key = "F", action = "fullscreen", opts = { all = true } },
    },
    -- System controls
    system = {
        { mod = "ALT", key = "SHIFT + M", action = "exit" },
        { mod = "CTRL + ALT", key = "DELETE", cmd = "wlogout" },
        { mod = "CTRL + ALT", key = "SHIFT + DELETE", cmd = "reboot" },
        { mod = "SUPER", key = "S", cmd = apps.screenshot },
        { mod = "SUPER", key = "L", cmd = "swaylock -c 000000" },
    },
    -- Window switching
    switching = {
        { mod = "ALT", key = "TAB", cmd = "snappy-switcher next" },
        { mod = "ALT", key = "SHIFT + TAB", cmd = "snappy-switcher prev" },
    },
    -- Media controls
    media = {
        { key = "XF86AudioRaiseVolume", cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%+", opts = { locked = true, repeating = true } },
        { key = "XF86AudioLowerVolume", cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%-", opts = { locked = true, repeating = true } },
        { key = "XF86AudioMute", cmd = "wpctl set-mute @DEFAULT_SINK@ toggle", opts = { locked = true } },
        { key = "XF86AudioMicMute", cmd = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", opts = { locked = true } },
        { key = "XF86MonBrightnessUp", cmd = "brightnessctl s 10%+", opts = { locked = true, repeating = true } },
        { key = "XF86MonBrightnessDown", cmd = "brightnessctl s 10%-", opts = { locked = true, repeating = true } },
        { key = "XF86AudioNext", cmd = "playerctl next", opts = { locked = true } },
        { key = "XF86AudioPlay", cmd = "playerctl play-pause", opts = { locked = true } },
        { key = "XF86AudioPause", cmd = "playerctl play-pause", opts = { locked = true } },
        { key = "XF86AudioPrev", cmd = "playerctl previous", opts = { locked = true } },
    },
}

--- Direction keys mapping
local directions = { "left", "right", "up", "down" }

--------------------------------------------------------------------------------
-- SETUP
--------------------------------------------------------------------------------

-- Monitors
setup_monitors(monitors)

-- Environment variables
set_env_vars(env_vars)

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("swaybg -i ~/wall0.png")
    hl.exec_cmd("dms run || caelestia shell -d")
    hl.exec_cmd("xrdb -merge ~/.Xresources")
end)


--------------------------------------------------------------------------------
-- LOOK AND FEEL
--------------------------------------------------------------------------------

-- Create animation curves
create_curves(curves)

-- Setup animations
setup_animations(animations)

-- Main config
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

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = false,
        vrr = 1,
    },

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

    xwayland = {
        force_zero_scaling = true,
    },
})

-- Workspace rules
for _, rule in ipairs(workspace_rules) do
    hl.workspace_rule(rule)
end

--------------------------------------------------------------------------------
-- WINDOW AND WORKSPACE RULES

-- Setup custom window rules
setup_window_rules(window_rules)

-- Assign applications to workspaces
for _, assignment in ipairs(app_assignments) do
    assign_to_workspace(assignment.class, assignment.workspace, assignment.silent)
end

================================================================================
-- KEYBINDINGS
================================================================================

local mainMod = "ALT"

-- Application launches
for _, keybind in ipairs(keybinds.apps) do
    app_bind(keybind.mod, keybind.key, apps[keybind.app])
end

-- Window management
for _, keybind in ipairs(keybinds.windows) do
    local action = keybind.action
    if action == "close" then
        bind(keybind.mod, keybind.key, hl.dsp.window.close())
    elseif action == "float" then
        bind(keybind.mod, keybind.key, hl.dsp.window.float(keybind.opts))
    elseif action == "pseudo" then
        bind(keybind.mod, keybind.key, hl.dsp.window.pseudo())
    elseif action == "fullscreen" then
        bind(keybind.mod, keybind.key, hl.dsp.window.fullscreen(keybind.opts))
    end
end

-- System controls
for _, keybind in ipairs(keybinds.system) do
    if keybind.action == "exit" then
        bind(keybind.mod, keybind.key, hl.dsp.exit())
    else
        bind(keybind.mod, keybind.key, hl.dsp.exec_cmd(keybind.cmd), keybind.opts)
    end
end

-- Window switching
for _, keybind in ipairs(keybinds.switching) do
    bind(keybind.mod, keybind.key, hl.dsp.exec_cmd(keybind.cmd))
end

-- Focus navigation (all directions)
for _, direction in ipairs(directions) do
    focus_bind(mainMod, direction, direction)
end

-- Move windows (all directions)
for _, direction in ipairs(directions) do
    move_bind(mainMod, "SHIFT + " .. direction, direction)
end

-- Workspace switching (1-9)
for i = 1, 9 do
    workspace_bind(mainMod, tostring(i), i)
    workspace_move_bind(mainMod, "SHIFT + " .. i, i)
end

-- Workspace 10 (0 key)
workspace_bind(mainMod, "0", 10)
workspace_move_bind(mainMod, "SHIFT + 0", 10)

-- Special workspace (scratchpad)
bind(mainMod, "S", hl.dsp.workspace.toggle_special("magic"))
bind(mainMod, "SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
bind(mainMod, "mouse_down", hl.dsp.focus({ workspace = "e+1" }), { mouse = true })
bind(mainMod, "mouse_up", hl.dsp.focus({ workspace = "e-1" }), { mouse = true })

-- Move/resize with mouse
bind(mainMod, "mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mainMod, "mouse:273", hl.dsp.window.resize(), { mouse =
