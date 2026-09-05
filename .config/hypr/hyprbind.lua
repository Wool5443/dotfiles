local apps = require("hyprapps")

local ipc = "noctalia msg "

local mainMod = "SUPER"

local function cmd(command)
    return hl.dsp.exec_cmd(command)
end

-- OBS
-- hl.bind("CTRL + 1", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
-- hl.bind("CTRL + 2", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))

-- Lockscreen
hl.bind("switch:off:Lid Switch", cmd(ipc .. "lockScreen lock"), { locked = true })

-- App start
hl.bind(mainMod .. " + b", cmd(apps.browser))
hl.bind(mainMod .. " + e", cmd(apps.fileManager))
hl.bind(mainMod .. " + t", cmd(apps.terminal))
-- hl.bind(mainMod .. " + c", cmd("code --enable-features=UseOzonePlatform --ozone-platform=wayland"))
-- hl.bind(mainMod .. " + c", cmd("code"))

hl.bind(mainMod .. " + f4", cmd("hyprctl kill"))

-- Tiling
hl.bind(mainMod .. " + x", hl.dsp.window.close())
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + v", hl.dsp.window.float())
hl.bind(mainMod .. " + p", hl.dsp.window.pin())
hl.bind(mainMod .. " + i", hl.dsp.layout("togglesplit"))

-- Launcher
hl.bind(mainMod .. " + r", cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + SHIFT + v", cmd(ipc .. "panel-toggle clipboard"))

-- Screenshots
hl.bind("Print", cmd("~/dotfiles/scripts/screenshot.sh region"))
hl.bind("SHIFT + Print", cmd('~/dotfiles/scripts/screenshot.sh "active -m output"'))
hl.bind("CTRL + Print", cmd("~/dotfiles/scripts/screenshot.sh window"))
hl.bind(mainMod .. " + Print", cmd("~/dotfiles/scripts/OCR.sh"))

hl.bind(mainMod .. " + SHIFT + Print", cmd("~/dotfiles/scripts/screencast.sh region"))
hl.bind(mainMod .. " + CTRL + Print", cmd("~/dotfiles/scripts/screencast.sh fullscreen"))

-- Switcher
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))
-- hl.bind("ALT + Tab", cmd("snappy-switcher next"))
-- hl.bind("ALT + SHIFT + Tab", cmd("snappy-switcher prev"))

-- Focus change
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + ALT + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + ALT + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + CTRL + SHIFT + h", hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + l", hl.dsp.window.move({ workspace = "+1", follow = true }))
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.window.move({ workspace = "+1", follow = true }))

-- Special
hl.bind(mainMod .. " + s", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Mouse change workspace
hl.config({
    binds = {
        scroll_event_delay = 0,
    },
})
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Resize
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

-- Media
hl.bind("ALT + M", cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioNext", cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", cmd("playerctl play-pause"), { locked = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- Brightness
hl.bind("XF86MonBrightnessUp", cmd("brightnessctl -e4 -n2 set 2%+"))
hl.bind("XF86MonBrightnessDown", cmd("brightnessctl -e4 -n2 set 2%-"))
