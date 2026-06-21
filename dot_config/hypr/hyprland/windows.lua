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
    match = { initial_title = "Calendar Reminders" },
    center = true,
    float = true,
    size = { "(monitor_w*0.5)", "(monitor_h*0.5)" }
})

hl.window_rule({
    name = "no-anim-telegram",
    match = { initial_title = "^Media viewer$", initial_class = "^org.telegram.desktop$" },
    no_anim = true,
})
