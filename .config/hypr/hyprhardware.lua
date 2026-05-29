hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "auto-up",
    scale = 1,
})

hl.config({
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle,grp:caps_toggle,grp:win_space_toggle",
        repeat_rate = 40,
        repeat_delay = 300,
        follow_mouse = 1,
        scroll_factor = 2,
        touchpad = {
            scroll_factor = 0.4,
            natural_scroll = true,
            clickfinger_behavior = true,
            disable_while_typing = false,
            drag_lock = true,
        },
        tablet = {
            transform = 0,
            output = "eDP-1",
        },
    },
    misc = {
        initial_workspace_tracking = 1,
        middle_click_paste = false,
        animate_manual_resizes = true,
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

for _, device in ipairs({
    "e-signal-usb-gaming-mouse",
    "2.4g-mouse-1",
}) do
    hl.device({
        name = device,
        sensitivity = -0.19,
        accel_profile = "flat",
    })
end

hl.device({
    name = "compx-vgn-f1",
    sensitivity = -0.89,
    accel_profile = "flat",
})

hl.device({
    name = "lift-mouse",
    sensitivity = -0.5,
    accel_profile = "flat",
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.gesture({
    fingers = 3,
    direction = "up",
    action = "special",
    workspace_name = "magic",
})

-- hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 2 })
-- hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1.2, mode = "mult" })
hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })
