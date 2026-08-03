-- Window resize helpers and logical-pixel width presets.

local utils = require("hyprland/utils")

-- Tweak widths here; keybinds and solo-pseudo both read from these.
local sizes = {
    xs = 1200,
    s  = 1400,
    m  = 1900,
    l  = 2400,
}
sizes.solo = sizes.m -- single-window pseudo default
sizes.presets = { sizes.xs, sizes.s, sizes.m, sizes.l } -- SUPER+ALT 1..4

local M = {
    sizes = sizes,
}

--- Resize a window to an exact size in logical pixels.
---@param win HL.Window
---@param width number
---@param height number
function M.exact(win, width, height)
    hl.dispatch(hl.dsp.window.resize({
        x = math.floor(width),
        y = math.floor(height),
        relative = false,
        window = win,
    }))
end

--- Resize the active (or given) window to a logical width and a height
--- fraction of the monitor. Pass width = nil for full monitor width.
---@param width number|nil
---@param height_ratio number
---@param win HL.Window|nil
function M.to(width, height_ratio, win)
    win = win or hl.get_active_window()
    if not win then return end

    local mon = win.monitor or hl.get_active_monitor()
    if not mon then return end

    local mon_w, mon_h = utils.logical_size(mon)
    M.exact(win, width or mon_w, mon_h * height_ratio)
end

--- Size a window to the solo preset width × full logical height and center it.
--- Does not change pseudo state — callers enable/disable that separately.
---@param win HL.Window
function M.solo(win)
    local mon = win.monitor
    if not mon then return end

    local _, height = utils.logical_size(mon)
    M.exact(win, sizes.solo, height)
    utils.center(win)
end

return M
