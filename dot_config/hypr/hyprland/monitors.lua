function hdmi(enabled)
    if enabled then
        hl.monitor({
            output = "desc:Samsung Electric Company SAMSUNG 0x01000E00",
            mode = "3840x2160@60",
            position = "-3840x0",
            scale = 1,
            cm = "auto",
            disabled = false
            -- mirror = "desc:ASUSTek COMPUTER INC VG279Q5R TALMDW005891"
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
