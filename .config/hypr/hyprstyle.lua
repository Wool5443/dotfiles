local function loadNoctaliaColors()
    local defaults = {
        primary = "rgb(ffb3b0)",
        surface = "rgb(181212)",
        secondary = "rgb(e6bdba)",
        error = "rgb(ffb4ab)",
    }
    local colors = {}

    for key, value in pairs(defaults) do
        colors[key] = value
    end

    local home = os.getenv("HOME")
    if not home then
        return colors
    end

    local file = io.open(home .. "/.config/hypr/noctalia/noctalia-colors.conf", "r")
    if not file then
        return colors
    end

    for line in file:lines() do
        local name, value = line:match("^%s*%$([%w_]+)%s*=%s*(rgb%([%x]+%))%s*$")
        if name and value then
            colors[name] = value
        end
    end

    file:close()
    return colors
end

local colors = loadNoctaliaColors()

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = colors.primary,
            inactive_border = colors.surface,
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    group = {
        col = {
            border_active = colors.secondary,
            border_inactive = colors.surface,
            border_locked_active = colors.error,
            border_locked_inactive = colors.surface,
        },
        groupbar = {
            col = {
                active = colors.secondary,
                inactive = colors.surface,
                locked_active = colors.error,
                locked_inactive = colors.surface,
            },
        },
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee000000,
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
        smart_resizing = true,
    },
    master = {
        new_status = "master",
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.2, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = false, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = false, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = false, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.2, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = false, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = false, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
