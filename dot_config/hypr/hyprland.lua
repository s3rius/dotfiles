-- Hyprland Lua Configuration
-- Migrated from hyprland.conf

------------------
---- MONITORS ----
------------------

function HDMI_STATE(enabled)
    if enabled then
        hl.monitor({
            output = "desc:Samsung Electric Company SAMSUNG 0x01000E00",
            disabled = false
        })
    else
        hl.monitor({
            output = "desc:Samsung Electric Company SAMSUNG 0x01000E00",
            disabled = true
        })
    end
end

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.monitor({
    output = "desc:Samsung Electric Company SAMSUNG 0x01000E00",
    mode = "3840x2160@60",
    position = "-3840x0",
    scale = 1,
    cm = "auto",
})

hl.monitor({
    output = "desc:ASUSTek COMPUTER INC VG279Q5R TALMDW005892",
    mode = "1920x1080@200",
    position = "0x0",
    scale = 1,
    cm = "auto",
})

hl.monitor({
    output = "desc:ASUSTek COMPUTER INC VG279Q5R TALMDW005891",
    mode = "1920x1080@200",
    position = "1920x0",
    scale = 1,
    cm = "auto",
})



---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local fileManager = "dolphin"
local menu = "wofi --show drun --conf ~/.config/hypr/wofi/config.conf --style ~/.config/hypr/wofi/style.css"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("udiskie &")
    hl.exec_cmd("gammastep &")
    hl.exec_cmd("waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css &")
    hl.exec_cmd("swaync -c ~/.config/hypr/swaync/config.json &")
    hl.exec_cmd("hyprpaper -c ~/.config/hypr/hyprpaper.conf &")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("hyprctl setcursor 'Bibata-Modern-Amber' 24")
    hl.exec_cmd("autotablet \"Lenovo Yoga Tablet Mode Control switch\"")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORM", "xcb")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("TERMINAL", "/usr/bin/kitty")
hl.env("XCURSOR_THEME", "Bibata-Modern-Amber")
hl.env("XCURSOR_SIZE", "24")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(D65D0EEE)", "rgba(458588EE)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
        allow_tearing = false,
    },

    decoration = {
        rounding = 20,
        shadow = {
            enabled = false,
        },
        blur = {
            enabled = true,
            size = 8,
            passes = 1,
            new_optimizations = true,
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
        new_on_top = true,
    },

    misc = {
        force_default_wallpaper = 0,
        close_special_on_empty = true,
    },
})


-- Bezier curves
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 10, bezier = "default" })


---------------------
---- KEYBINDS ----
---------------------

local mainMod = "SUPER"

-- App binds
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + M", hl.dsp.layout("togglesplit"))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + A", hl.dsp.window.pin())

-- Move windows
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- AUX keys
hl.bind("Print", hl.dsp.exec_cmd("grim - | tee /tmp/screenshot.png | wl-copy"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("slurp | grim -g - - | tee /tmp/screenshot.png | wl-copy"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })

-- Workspace binds
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Submaps
hl.bind(mainMod .. " + R", hl.dsp.submap("resizing_window"))
hl.define_submap("resizing_window", function()
    hl.bind("right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)


-----------------------
---- INPUT ----
-----------------------

hl.config({
    input = {
        kb_layout = "us,ru",
        kb_model = "",
        kb_variant = "",
        kb_options = "grp:caps_toggle",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
            disable_while_typing = false,
        },

        touchdevice = {
            output = "eDP-1",
        },

        tablet = {
            output = "eDP-1",
        },
    },

    cursor = {
        inactive_timeout = 2,
    },

    gestures = {
        workspace_swipe_touch = true,
        workspace_swipe_cancel_ratio = 0.15,
    },
})


----------------
---- DEVICE ----
----------------

-- Example per-device config
-- hl.device({
--     name = "device-name",
-- })


-------------------------
---- WINDOW RULES ----
-------------------------

hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "no-focus-steam-toast",
    match = { class = "^steam$", title = "^notificationtoasts_.*_desktop$" },
    no_focus = true,
})

hl.window_rule({
    name = "center-thunderbird-reminder",
    match = { title = "Reminder ", class = "^thunderbird$" },
    center = true,
})

hl.window_rule({
    name = "no-anim-telegram",
    match = { initial_title = "^Media viewer$", initial_class = "^org.telegram.desktop$" },
    no_anim = true,
})


-----------------
---- XWAYLAND ----
-----------------

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
