local envs = {
    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE = "wayland",
    MOZ_ENABLE_WAYLAND = "1",
    QT_QPA_PLATFORM = "xcb",
    QT_QPA_PLATFORMTHEME = "qt5ct",
    TERMINAL = "/usr/bin/kitty",
    XCURSOR_THEME = "Bibata-Modern-Amber",
    XCURSOR_SIZE = "24",
}

for key, val in pairs(envs) do
    hl.env(key, val)
end
