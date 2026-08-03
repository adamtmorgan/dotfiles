---------------------
---- KEYBINDINGS ----
---------------------
-- Compositor / system binds only. App launch binds live in hyprland/app/*.lua

local mods = require("hyprland/mods")

local mainMod   = mods.main
local resizeMod = mods.resize

-----------------------------------------------------------------------------------
-- Main
-----------------------------------------------------------------------------------
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("uwsm stop"))

hl.bind(mainMod .. " + B", hl.dsp.global("quickshell:barToggle"))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S", hl.dsp.layout("swapsplit"))   -- dwindle only
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + SHIFT + f", hl.dsp.focus({ window = "floating" }))
hl.bind(mainMod .. " + SHIFT + t", hl.dsp.focus({ window = "tiled" }))

-- Shrink horizontal to half screen size
hl.bind(mainMod .. " + SHIFT + t", hl.dsp.focus({ window = "tiled" }))

-- Toggle floating (your "promote to floating" key)
hl.bind(mainMod .. " + f", function()
    local was_floating = false
    local win = hl.get_active_window()
    if win then
        was_floating = win.floating
    end

    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

    if not was_floating then
        local mon = hl.get_active_monitor()
        local target_w = math.floor(mon.width * 0.5)
        local target_h = math.floor(mon.height * 0.75)
        hl.dispatch(hl.dsp.window.resize({
            x = target_w,
            y = target_h,
            exact = true
        }))
        hl.dispatch(hl.dsp.window.center())
    end
end)

-- Center any floating window
hl.bind(mainMod .. " + c", hl.dsp.window.center())

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Equalize splits
hl.bind(mainMod .. " + e", hl.dsp.layout("splitratio 1.0 exact"))

-----------------------------------------------------------------------------------
-- Resizing (SUPER + ALT + 1..4)
-----------------------------------------------------------------------------------
-- Widths are logical pixels (scale-aware). Height uses the logical monitor size.

local RESIZE_WIDTHS = {
    1200,  -- 1: xs (use with lower height)
    1400, -- 2: s
    1900, -- 3: medium (matches solo pseudo default)
    2400, -- 4: large
}

---@param width number|nil logical px; nil = full monitor width
---@param height_ratio number fraction of logical monitor height (1 = full)
local function resizeWindow(width, height_ratio)
    local mon = hl.get_active_monitor()
    if not mon then return end

    local mon_w = mon.width / mon.scale
    local mon_h = mon.height / mon.scale
    hl.dispatch(hl.dsp.window.resize({
        x = math.floor(width or mon_w),
        y = math.floor(mon_h * height_ratio),
        relative = false,
    }))
end

hl.bind(resizeMod .. "+ 1", function() resizeWindow(RESIZE_WIDTHS[1], 0.8) end)
hl.bind(resizeMod .. "+ 2", function() resizeWindow(RESIZE_WIDTHS[2], 1) end)
hl.bind(resizeMod .. "+ 3", function() resizeWindow(RESIZE_WIDTHS[3], 1) end)
hl.bind(resizeMod .. "+ 4", function() resizeWindow(RESIZE_WIDTHS[4], 1) end)
hl.bind(resizeMod .. "+ 5", function() resizeWindow(nil, 1) end)

-----------------------------------------------------------------------------------
-- Workspaces
-----------------------------------------------------------------------------------
hl.bind(mainMod .. " + BACKSLASH", hl.dsp.workspace.toggle_special("1password"))
hl.bind(mainMod .. " + BRACKETRIGHT", hl.dsp.workspace.toggle_special("media"))
hl.bind(mainMod .. " + BRACKETLEFT", hl.dsp.workspace.toggle_special("scratchpad"))

-----------------------------------------------------------------------------------
-- Laptop multimedia keys for volume and LCD brightness
-----------------------------------------------------------------------------------
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-----------------------------------------------------------------------------------
-- System remaps
-----------------------------------------------------------------------------------

-- Next tab: Alt + Shift + ]
hl.bind("ALT + SHIFT + bracketright", hl.dsp.send_shortcut({
    mods = "CTRL",
    key = "Tab"
}))

-- Previous tab: Alt + Shift + [
hl.bind("ALT + SHIFT + bracketleft", hl.dsp.send_shortcut({
    mods = "CTRL + SHIFT",
    key = "Tab",
}))
