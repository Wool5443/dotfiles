hl.window_rule({ match = { class = "blueman-manager" }, float = true })

hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })

hl.window_rule({ match = { class = "pavucontrol" }, float = true })
hl.window_rule({ match = { title = "Open File" }, float = true })
hl.window_rule({ match = { class = "org.matplotlib.Matplotlib3" }, float = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({ match = { title = "Steam Settings" }, float = true })
hl.window_rule({ match = { title = "Friends List" }, float = true })
hl.window_rule({ match = { title = ".*Properties.*" }, float = true })
hl.window_rule({ match = { title = "File Operation Progress" }, float = true })
hl.window_rule({ match = { class = "qalculate-gtk" }, float = true })

hl.window_rule({ match = { class = "zen" }, workspace = 1, fullscreen = true })
hl.window_rule({ match = { class = "TelegramDesktop" }, workspace = 2 })
hl.window_rule({ match = { class = "spotify" }, workspace = 10 })

hl.window_rule({ match = { title = ".*Picture-in-Picture.*" }, float = true })
-- hl.window_rule({ match = { title = ".*Picture-in-Picture.*" }, pin = true })

hl.window_rule({ match = { class = "albert" }, no_blur = true })
hl.window_rule({ match = { class = "albert" }, border_size = 0 })

hl.window_rule({ match = { title = "as_toolbar" }, pin = true })
hl.window_rule({ match = { title = "zoom_linux_float_video_window" }, float = true })

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
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
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = { "20", "monitor_h-120" },
    float = true,
})
