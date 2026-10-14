# Fedora KDE dotfiles

KDE Plasma 6 on Wayland, with Kitty, Dolphin, Zen, ten virtual desktops,
and application configurations. The Hyprland files remain available for the
original session; Plasma uses its own panel, launcher,
clipboard, lock screen, window switcher, audio controls, and brightness controls.

## Setup

Install KDE Plasma, `xdg-desktop-portal-kde`, Spectacle, Kitty, ImageMagick,
`wl-clipboard`, Tesseract with English and Russian language data, and
`libnotify`. Select **Plasma (Wayland)** at the login screen.
The Zen, Telegram, Spotify, and GPU Screen Recorder autostart entries require
the corresponding Flatpak applications; Throne requires `throne` on PATH.
Remove any autostart entries for applications you do not use.

Back up matching files in your home directory before installing. Copy these
paths from this checkout to the same relative paths under your home directory:

- `.config/kwinrc`
- `.config/kglobalshortcutsrc`
- `.config/plasma-workspace/env/development.sh`
- `.config/xdg-desktop-portal/kde-portals.conf`
- `.config/autostart/*.desktop`
- `scripts/*.sh`

Install the KWin and shortcut files while logged out of Plasma, using a TTY,
to prevent the running desktop from overwriting them. If you already have KDE
customizations, merge the supplied keys into your existing files instead of
replacing them. Log out and back in after installing the profile.
The remaining application configurations can be copied individually as needed.

Plasma supplies the Qt theme, scaling, cursor, and session environment. Configure
these in System Settings. Do not source `hyprenv.lua` or launch
snappy-switcher in the Plasma session. The KDE portal profile retains this
repository's GNOME Keyring secret provider, so keep `gnome-keyring` installed.
Use System Settings → Autostart for additional applications or rclone mounts;
the Hyprland Google Drive mounts are not automatically started by Plasma.

## Shortcuts

| Shortcut | Action |
| --- | --- |
| Meta+T / Meta+B / Meta+E | Kitty / Zen / Dolphin |
| Meta+R | Plasma launcher |
| Meta+Shift+V | Plasma clipboard |
| Meta+X / Meta+F / Meta+P | Close / fullscreen / keep window above others |
| Meta+H/J/K/L | Focus window left/down/up/right |
| Meta+1…9, Meta+0 | Switch to desktop 1…10 |
| Meta+Shift+1…9, Meta+Shift+0 | Move window to desktop 1…10 |
| Alt+Tab / Alt+Shift+Tab | Native KWin window switcher |
| Print / Shift+Print / Ctrl+Print | Spectacle region / current monitor / active window |
| Meta+Shift+Print / Meta+Ctrl+Print | Spectacle region / screen recording |

Meta is the Super/Windows key. The Plasma task-manager number shortcuts are
disabled to free Meta+1…0 for virtual desktops. KWin's tile editor shortcut is
disabled to free Meta+T for Kitty. Configure tiling through System Settings or
assign another shortcut to the tile editor.

## Capture scripts

The scripts select Spectacle when `XDG_CURRENT_DESKTOP` contains `KDE`, and use
the original Hyprland tools otherwise:

```sh
~/scripts/screenshot.sh region
~/scripts/screenshot.sh active output
~/scripts/screenshot.sh window
~/scripts/OCR.sh
~/scripts/screencast.sh region
~/scripts/screencast.sh output
~/scripts/screencast.sh window  # KDE only
```

Screenshots go to `~/Pictures/Screenshots`; the notification offers editing or
opening the folder. OCR copies recognized text to the Wayland clipboard;
override the default languages with `OCR_LANGUAGES=eng` if desired.
Add a custom command shortcut for `~/scripts/OCR.sh` in System Settings →
Keyboard → Shortcuts to restore the OCR binding.

On KDE, `screencast.sh fullscreen` opens Spectacle's screen recording flow:
select the screen and use Spectacle's controls to finish and save the recording.
Running the same recording command again toggles recording. The `SCREENCAST_*`
encoding options and wf-recorder PID toggle apply only to Hyprland.

Reference: [Spectacle handbook](https://docs.kde.org/trunk_kf6/en/spectacle/spectacle/starting.html)
and [portal configuration](https://flatpak.github.io/xdg-desktop-portal/docs/configuration-file.html).
