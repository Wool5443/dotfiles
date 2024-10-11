-- This script changes playback direction to "backward" if the comma "," key is held for 0.2 seconds
-- and reverts it to forward direction when the comma key is released. If the comma is tapped (not held),
-- it behaves normally and steps backward 1 frame.

local hold_threshold = 0.2
local is_rewinding = false
local was_paused = false
local timer = nil

local function rewind_on()
    is_rewinding = true
    -- Check and remember the current pause state
    was_paused = mp.get_property_bool("pause")
    
    if was_paused then
        mp.set_property_bool("pause", false)
    end
    
    mp.set_property("play-direction", "backward")
    mp.set_osd_ass(0, 0, "◀◀ REWIND")
end

local function rewind_off()
    mp.set_property("play-direction", "forward")
    
    -- If it was paused before we started, put it back on pause
    if was_paused then
        mp.set_property_bool("pause", true)
    end
    
    mp.set_osd_ass(0, 0, "")
    is_rewinding = false
    -- Clear persistent ASS text
    mp.set_osd_ass(0, 0, "")
    -- Force OSD to refresh/clear
    mp.osd_message("", 0)
    mp.osd_message("", 1)
end

local function handle_rewind(event)
    if event.event == "down" then
        timer = mp.add_timeout(hold_threshold, rewind_on)
    elseif event.event == "up" then
        if timer then 
            timer:kill() 
            timer = nil 
        end
        
        if is_rewinding then
            rewind_off()
        else
            -- Default behavior: back one frame
            mp.commandv("frame_back_step")
        end
    end
end

mp.add_forced_key_binding(",", "rewind_hold", handle_rewind, {complex = true})
