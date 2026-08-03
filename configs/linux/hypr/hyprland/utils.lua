-- Shared Hyprland Lua helpers (windows, monitors, pseudo).

local M = {}

--- Whether a window should count toward tiled workspace occupancy.
--- Excludes floating, hidden, and fullscreen windows.
---@param w HL.Window|nil
---@return boolean
function M.is_countable(w)
    return w ~= nil
        and not w.floating
        and not w.hidden
        and (w.fullscreen == nil or w.fullscreen == 0)
end

--- Tiled (countable) windows on a workspace, optionally skipping one address.
---@param ws HL.Workspace|nil
---@param exclude_addr string|nil
---@return HL.Window[]
function M.tiled_windows(ws, exclude_addr)
    local wins = {}
    if not ws then return wins end
    for _, w in ipairs(ws:get_windows()) do
        if w.address ~= exclude_addr and M.is_countable(w) then
            wins[#wins + 1] = w
        end
    end
    return wins
end

--- Monitor size in logical pixels (physical size ÷ scale).
--- Use these units for resize/move so values look consistent across HiDPI.
---@param mon HL.Monitor
---@return number width
---@return number height
function M.logical_size(mon)
    return mon.width / mon.scale, mon.height / mon.scale
end

--- Force-disable pseudotiling on a window.
--- Prefer action "off"/"on" over "unset"/"set" — the latter silently toggle.
---@param win HL.Window|nil
function M.pseudo_off(win)
    if not win then return end
    hl.dispatch(hl.dsp.window.pseudo({ action = "off", window = win }))
end

--- Force-enable pseudotiling on a window.
---@param win HL.Window|nil
function M.pseudo_on(win)
    if not win then return end
    hl.dispatch(hl.dsp.window.pseudo({ action = "on", window = win }))
end

--- Center a window on its monitor.
---@param win HL.Window
function M.center(win)
    hl.dispatch(hl.dsp.window.center({ window = win }))
end

return M
