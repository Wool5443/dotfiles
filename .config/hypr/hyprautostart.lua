hl.on("hyprland.start", function()
    hl.exec_cmd("qs -c noctalia-shell")
    hl.exec_cmd("sh -c '~/.config/rofi/scripts/file-index >/dev/null 2>&1 &'")
end)
