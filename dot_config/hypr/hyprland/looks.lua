local function set_cursor(name, size)
    hl.exec_cmd("hyprctl setcursor '" .. name .. "' " .. tostring(size))
    hl.env("XCURSOR_THEME", name)
    hl.env("XCURSOR_SIZE", tostring(size))
end

hl.on("hyprland.start", function()
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-blue-standard+default"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface icon-theme "Papirus"')
    set_cursor("Bibata-Modern-Ice", 24)
end)

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border = { colors = { "#89b4fa", "#b4befe" }, angle = 45 },
            inactive_border = "#313244",
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
    xwayland = {
        force_zero_scaling = true
    }
})


-- Bezier curves
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 10, bezier = "default" })
