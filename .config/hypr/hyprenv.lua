local cursorSize = "14"
local cursorTheme = "oreo_pink_cursors"

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_DATA_DIRS",
    "/usr/share:/usr/local/share:/var/lib/flatpak/exports/share:/home/twenty/.local/share:/home/twenty/.local/share/flatpak/exports/share")
hl.env("XDG_CONFIG_HOME", os.getenv("HOME") .. "/.config")

hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_ENABLE_HIGHDPI_SCALING", "0")
hl.env("QT_SELECT", "6")

hl.env("CLUTTER_BACKEND", "wayland")
hl.env("SDL_VIDEODRIVER", "x11")
hl.env("ECORE_EVAS_ENGINE", "wayland")
hl.env("ELM_ENGINE", "wayland")
hl.env("ELM_ACCEL", "opengl")
hl.env("WINIT_UNIX_BACKEND", "wayland")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.env("PATH", os.getenv("PATH") .. ":/home/twenty/.cargo/bin")
hl.env("PATH", os.getenv("PATH") .. ":/home/twenty/.local/bin")
hl.env("PATH", os.getenv("PATH") .. ":/usr/lib/jvm/jre-25/bin")

hl.env("XCURSOR_SIZE", cursorSize)
hl.env("XCURSOR_THEME", cursorTheme)
hl.env("HYPRCURSOR_SIZE", cursorSize)
hl.env("HYPRCURSOR_THEME", cursorTheme)

hl.env("CC", "gcc")
hl.env("CXX", "g++")
hl.env("TERM", "kitty")
hl.env("CMAKE_GENERATOR", "Ninja Multi-Config")
