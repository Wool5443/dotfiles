local apps = require("hyprapps")

local main_mod = "SUPER"

local function cmd(command)
    return hl.dsp.exec_cmd(command)
end

-- OBS
-- hl.bind("CTRL + 1", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))
-- hl.bind("CTRL + 2", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))

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

-- Screenshots
hl.bind("Print", cmd("~/scripts/screenshot.sh region"))
hl.bind("SHIFT + Print", cmd("~/scripts/screenshot.sh active output"))
hl.bind("CTRL + Print", cmd("~/scripts/screenshot.sh window"))
hl.bind(main_mod .. " + Print", cmd("~/scripts/OCR.sh"))

-- hl.bind("Print", cmd("~/.local/bin/snypr screenshot --interactive --edit"))
-- hl.bind("SHIFT + Print", cmd("~/.local/bin/snypr screenshot --focused --edit"))
-- hl.bind("CTRL + Print", cmd("~/.local/bin/snypr screenshot --window --edit"))
-- hl.bind("ALT + Print", cmd("~/.local/bin/snypr screenshot --full"))

-- Snypr live drawing: toggle overlay and recover keyboard focus from click-through.
hl.bind(main_mod .. " + ALT + Print", cmd("~/.local/bin/snypr draw --via-daemon"))
hl.bind(main_mod .. " + ALT + p", cmd("~/.local/bin/snypr draw --via-daemon --toggle-passthrough"))

-- Snypr live drawing: toggle overlay and recover keyboard focus from click-through.
hl.bind(main_mod .. " + ALT + Print", cmd("~/.local/bin/snypr draw --via-daemon"))
hl.bind(main_mod .. " + ALT + p", cmd("~/.local/bin/snypr draw --via-daemon --toggle-passthrough"))

-- hl.bind("Print", cmd("~/dotfiles/scripts/screenshot.sh region"))
-- hl.bind("SHIFT + Print", cmd('~/dotfiles/scripts/screenshot.sh "active -m output"'))
-- hl.bind("CTRL + Print", cmd("~/dotfiles/scripts/screenshot.sh window"))
-- hl.bind(mainMod .. " + Print", cmd("~/dotfiles/scripts/OCR.sh"))

-- hl.bind(mainMod .. " + SHIFT + Print", cmd("~/dotfiles/scripts/screencast.sh region"))
-- hl.bind(mainMod .. " + CTRL + Print", cmd("~/dotfiles/scripts/screencast.sh fullscreen"))

-- Switcher
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

hl.bind("XF86AudioRaiseVolume", cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true})
hl.bind("XF86AudioLowerVolume", cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true})
hl.bind("XF86AudioMute", cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Brightness
hl.bind("XF86MonBrightnessUp", cmd("brightnessctl set +5%"), { locked = true, repeating = true})
hl.bind("XF86MonBrightnessDown", cmd("brightnessctl set 5%-"), { locked = true, repeating = true})
