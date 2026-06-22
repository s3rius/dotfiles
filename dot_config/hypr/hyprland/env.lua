local envs = {
    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE = "wayland",
    MOZ_ENABLE_WAYLAND = "1",
    QT_QPA_PLATFORM = "xcb",
    QT_QPA_PLATFORMTHEME = "gtk3",
    TERMINAL = "/usr/bin/kitty",
}

for key, val in pairs(envs) do
    hl.env(key, val)
end
