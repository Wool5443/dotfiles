hl.on("hyprland.start", function()
    -- System
    hl.exec_cmd(
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprland-session.target")

    -- GDrive
    hl.exec_cmd("rclone mount Google: ~/GoogleDrive --vfs-cache-mode full")
    hl.exec_cmd("rclone mount Google: ~/SharedDrive --drive-shared-with-me --vfs-cache-mode full")

    -- Shell
    hl.exec_cmd("noctalia")
    hl.exec_cmd("snappy-switcher --daemon")

    -- Apps
    hl.exec_cmd("flatpak run app.zen_browser.zen", { workspace = "1" })
    hl.exec_cmd("flatpak run org.telegram.desktop", { workspace = "2 silent" })
    -- hl.exec_cmd("karing")
    hl.exec_cmd("/opt/Throne/Throne -tray")
    hl.exec_cmd("flatpak run com.spotify.Client", { workspace = "10" })
    hl.exec_cmd("flatpak run com.dec05eba.gpu_screen_recorder gsr-ui")
end)


-- hl.exec_cmd("wl-paste --type text --watch cliphist store")
-- hl.exec_cmd("wl-paste --type image --watch cliphist store")
-- hl.exec_cmd("systemctl --user restart xdg-desktop-portal.service")
