-- Hyprland main configuration.
-- All imported files are in ./hyprland/ folder.
-- Configured according to https://wiki.hypr.land/Configuring

-- Display output configurations.
require("hyprland.monitors")
-- All that should run on startup.
require("hyprland.startup")
-- Theme, layout and animations
require("hyprland.looks")
-- ALL keybinding
require("hyprland.keybinds")
-- For keyboard and other peripherals
require("hyprland.inputs")
-- Fine-grained window configuration.
require("hyprland.windows")
