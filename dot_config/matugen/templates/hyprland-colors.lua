-- Generated using MUTAGEN

hl.on("hyprland.start", function()
    hl.exec_cmd("matugen image {{image}} --contrast 0.5 --prefer darkness --show-colors ")
end)


return {
    image = "{{image}}",
<* for name, value in colors *>
    {{name}} = "0xff{{value.default.hex_stripped}}",
<* endfor *>
}
