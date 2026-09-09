local apps = require("hyprapps")

local ipc = "noctalia msg "

local main_mod = "SUPER"

local function cmd(command)
    return hl.dsp.exec_cmd(command)
end

-- OBS
-- hl.bind("CTRL + 1", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
-- hl.bind("CTRL + 2", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))

-- Lockscreen
hl.bind("switch:off:Lid Switch", cmd(ipc .. "lockScreen lock"), { locked = true })

-- App start
hl.bind(main_mod .. " + b", cmd(apps.browser))
hl.bind(main_mod .. " + e", cmd(apps.fileManager))
hl.bind(main_mod .. " + t", cmd(apps.terminal))
-- hl.bind(mainMod .. " + c", cmd("code --enable-features=UseOzonePlatform --ozone-platform=wayland"))
-- hl.bind(mainMod .. " + c", cmd("code"))

hl.bind(main_mod .. " + f4", cmd("hyprctl kill"))

-- Tiling
hl.bind(main_mod .. " + x", hl.dsp.window.close())
hl.bind(main_mod .. " + f", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(main_mod .. " + v", hl.dsp.window.float())
hl.bind(main_mod .. " + p", hl.dsp.window.pin())
hl.bind(main_mod .. " + i", hl.dsp.layout("togglesplit"))

-- Launcher
hl.bind(main_mod .. " + r", cmd(ipc .. "panel-toggle launcher"))
hl.bind(main_mod .. " + SHIFT + v", cmd(ipc .. "panel-toggle clipboard"))
hl.bind(main_mod .. " + period", cmd(ipc .. "panel-toggle liamwh/emoji-picker:wide"))

-- Screenshots
hl.bind("Print", cmd(ipc .. "plugin alexander/screen-toolkit:service all annotate"))
hl.bind("SHIFT + Print", cmd(ipc .. "plugin alexander/screen-toolkit:service all annotateFullscreen"))
hl.bind("CTRL + Print", cmd(ipc .. "plugin alexander/screen-toolkit:service all annotateWindow"))
hl.bind(main_mod .. " + Print", cmd(ipc .. "plugin alexander/screen-toolkit:service all ocr"))

-- hl.bind("Print", cmd("~/dotfiles/scripts/screenshot.sh region"))
-- hl.bind("SHIFT + Print", cmd('~/dotfiles/scripts/screenshot.sh "active -m output"'))
-- hl.bind("CTRL + Print", cmd("~/dotfiles/scripts/screenshot.sh window"))
-- hl.bind(mainMod .. " + Print", cmd("~/dotfiles/scripts/OCR.sh"))

-- hl.bind(mainMod .. " + SHIFT + Print", cmd("~/dotfiles/scripts/screencast.sh region"))
-- hl.bind(mainMod .. " + CTRL + Print", cmd("~/dotfiles/scripts/screencast.sh fullscreen"))

-- Switcher
-- hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod alt"))
hl.bind("SHIFT + ALT + Tab", hl.dsp.exec_cmd("snappy-switcher prev --mod alt"))

-- Focus change
hl.bind(main_mod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(main_mod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(main_mod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(main_mod .. " + j", hl.dsp.focus({ direction = "d" }))
hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move windows
hl.bind(main_mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(main_mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(main_mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(main_mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(main_mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(main_mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(main_mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))
hl.bind(main_mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(main_mod .. " + ALT + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + ALT + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + ALT + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + ALT + right", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(main_mod .. " + CTRL + SHIFT + h", hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(main_mod .. " + CTRL + SHIFT + left", hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(main_mod .. " + CTRL + SHIFT + l", hl.dsp.window.move({ workspace = "+1", follow = true }))
hl.bind(main_mod .. " + CTRL + SHIFT + right", hl.dsp.window.move({ workspace = "+1", follow = true }))

-- Special
hl.bind(main_mod .. " + s", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse resize
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Mouse change workspace
hl.config({
    binds = {
        scroll_event_delay = 0,
    },
})
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Resize
hl.bind(main_mod .. " + CTRL + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(main_mod .. " + CTRL + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(main_mod .. " + CTRL + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(main_mod .. " + CTRL + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(main_mod .. " + CTRL + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(main_mod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(main_mod .. " + CTRL + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
hl.bind(main_mod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

-- Media
hl.bind("ALT + M", cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioNext", cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", cmd("playerctl play-pause"), { locked = true })

hl.bind("XF86AudioRaiseVolume", cmd(ipc .. "volume-up"), { locked = true, repeating = true})
hl.bind("XF86AudioLowerVolume", cmd(ipc .. "volume-down"), { locked = true, repeating = true})
hl.bind("XF86AudioMute", cmd(ipc .. "volume-mute"))

-- Brightness
hl.bind("XF86MonBrightnessUp", cmd(ipc .. "brightness-up"), { locked = true, repeating = true})
hl.bind("XF86MonBrightnessDown", cmd(ipc .. "brightness-down"), { locked = true, repeating = true})
