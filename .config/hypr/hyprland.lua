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

-- For Noctalia Color templates
require("noctalia").apply_theme()
