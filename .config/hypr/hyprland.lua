local function file_exists(name)
   local f = io.open(name, "r")
   if f then
      f:close()
      return true
   else
      return false
   end
end


require("hyprapps")
require("hyprenv")
require("hyprautostart")
require("hyprhardware")
require("hyprstyle")
require("hyprbind")
require("hyprwindowrules")

if file_exists(".secretenv.lua") then
    require(".secretenv.lua")
end

-- For Noctalia Color templates
require("noctalia").apply_theme()
