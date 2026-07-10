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
local passwordManager = "1password"

-- Web apps. Installed w/ brave. Found in ~/.local/share/applications/brave-ggjocahimgaohmigbfhghnlfcnjemagj-Default.desktop
local grok            = "/opt/brave-bin/brave --profile-directory=Default --app-id=ggjocahimgaohmigbfhghnlfcnjemagj"

-----------------------------------------------------------------------------------
-- Prefixes
-----------------------------------------------------------------------------------
local mainMod         = "SUPER" -- Sets "Windows" key as main modifier
local openAppMod      = "SUPER + ALT"

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
hl.bind(mainMod .. " + R", hl.dsp.layout("rotatesplit")) -- dwindle only
hl.bind(mainMod .. " + S", hl.dsp.layout("swapsplit"))   -- dwindle only
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(mainMod .. " + SHIFT + f", hl.dsp.focus({ window = "floating" }))
hl.bind(mainMod .. " + SHIFT + t", hl.dsp.focus({ window = "tiled" }))
-- hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ next = true }))  -- or similar cyclenext variant

-- Groups
-- Example group-related binds
local mainMod = "SUPER"

-- Toggle floating (your "promote to floating" key)
hl.bind(mainMod .. " + f", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.center())
end)

-- Center any floating window
hl.bind(mainMod .. " + c", hl.dsp.window.center())

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Equalize splits
hl.bind(mainMod .. " + e", hl.dsp.layout("splitratio 1.0 exact"))

-----------------------------------------------------------------------------------
-- Apps
-----------------------------------------------------------------------------------
hl.bind(openAppMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(openAppMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(openAppMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(openAppMod .. " + G", hl.dsp.exec_cmd(grok))
hl.bind(openAppMod .. " + S", hl.dsp.exec_cmd(steam))
hl.bind(openAppMod .. " + P", hl.dsp.exec_cmd(passwordManager))

-- =====================
-- Workspace Rules (Special / Scratchpad)
-- =====================

-- 1Password special workspace (floats + auto-launches)
hl.workspace_rule({
    workspace = "special:1password",
    on_created_empty = "[float] 1password --show",
    persistent = true,
})
hl.bind(openAppMod .. " + P", hl.dsp.workspace.toggle_special("1password"))

-- General scratchpad for random terminals
hl.workspace_rule({
    workspace = "special:scratchpad",
    on_created_empty = "ghostty"
    -- You can also do "[float] foot" if you want everything floating here
})

-- Optional: Force floating + nice defaults on the scratchpad workspace
-- hl.window_rule({
--     match = { workspace = "special:scratchpad" },
--     float = true,
--     size = { 800, 600 },        -- optional fixed size
--     center = true,
-- })

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
