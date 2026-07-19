---------------------
---- KEYBINDINGS ----
---------------------

-----------------------------------------------------------------------------------
-- Apps
-----------------------------------------------------------------------------------
local terminal        = "ghostty"
local fileManager     = "dolphin"
local browser         = "brave"
local menu            = "hyprlauncher"
local steam           = "steam"
local passwordManager = "[float] 1password --show"

-- Web apps. Installed w/ brave. Found in ~/.local/share/applications/brave-ggjocahimgaohmigbfhghnlfcnjemagj-Default.desktop
local grok            = "/opt/brave-bin/brave --profile-directory=Default --app-id=ggjocahimgaohmigbfhghnlfcnjemagj"

-----------------------------------------------------------------------------------
-- Prefixes
-----------------------------------------------------------------------------------
local mainMod         = "SUPER"       -- Sets "Windows" key as main modifier
local openAppMod      = "SUPER + ALT"
local resizeMod       = "SUPER + ALT" -- Limit to num keys

-----------------------------------------------------------------------------------
-- Main
-----------------------------------------------------------------------------------
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + Q",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

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
-- hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ next = true }))  -- or similar cyclenext variant

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
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
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
-- Resizing
-----------------------------------------------------------------------------------

local resizeByScreen = function(width_ratio, height_ratio)
    local mon = hl.get_active_monitor()
    if not mon then return end

    local width = math.floor(mon.width * width_ratio)
    local height = math.floor(mon.height * height_ratio)
    hl.dispatch(hl.dsp.window.resize({
        x = width,
        y = height,
        relative = false
    }))
end

hl.bind(resizeMod .. "+ 1", function() resizeByScreen(0.25, 0.7) end)
hl.bind(resizeMod .. "+ 2", function() resizeByScreen(0.33, 1) end)
hl.bind(resizeMod .. "+ 3", function() resizeByScreen(0.5, 1) end)
hl.bind(resizeMod .. "+ 4", function() resizeByScreen(1, 1) end)

-----------------------------------------------------------------------------------
-- Apps
-----------------------------------------------------------------------------------
hl.bind(openAppMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(openAppMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(openAppMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(openAppMod .. " + S", hl.dsp.exec_cmd(steam))
hl.bind(openAppMod .. " + SHIFT + S", hl.dsp.exec_cmd(steam .. " -silent steam://open/gamepadui"))
hl.bind(openAppMod .. " + G", hl.dsp.exec_cmd(grok))

-----------------------------------------------------------------------------------
-- Workspaces
-----------------------------------------------------------------------------------
hl.bind(mainMod .. " + BACKSLASH", hl.dsp.workspace.toggle_special("1password"))
hl.bind(openAppMod .. " + P", hl.dsp.exec_cmd(passwordManager))
hl.bind(mainMod .. " + 0", hl.dsp.workspace.toggle_special("scratchpad"))

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
