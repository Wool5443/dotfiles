hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "hyprpicker" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "snappy-switcher" }, animation = "fade" })

hl.window_rule({ match = { class = "org\\.pulseaudio\\.pavucontrol" }, float = true })
hl.window_rule({ match = { title = "[Ss]ettings" }, float = true })
hl.window_rule({ match = { class = "org\\.gnome\\.NautilusPreviewer" }, float = true })
hl.window_rule({ match = { title = "Qalculate!" }, float = true })
hl.window_rule({ match = { title = "Bitwarden" }, float = true })
hl.window_rule({ match = { class = "photoshop\\.exe" }, float = true })
hl.window_rule({ match = { class = "Friends List" }, float = true })
hl.window_rule({ match = { class = "karing" }, float = true })

hl.window_rule({ match = { title = ".*Picture-in-Picture.*" }, float = true })

hl.window_rule({ match = { title = "as_toolbar" }, pin = true })
hl.window_rule({ match = { title = "zoom_linux_float_video_window" }, float = true })

hl.window_rule({ match = { class = "mpv" }, render_unfocused = true })

hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

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
