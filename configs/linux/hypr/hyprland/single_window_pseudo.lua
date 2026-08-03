-- NOTE: AI-authored

-- When a normal workspace transitions to exactly one tiled window (0→1 or >1→1),
-- enable pseudo tiling and shrink to a fixed logical width at full height.
-- Leaving solo (1→2+) disables pseudo on that window so normal tiling resumes.
--
-- Note: hl.dsp.window.pseudo action must be on/off (or enable/disable).
-- "set"/"unset" are not recognized and silently become toggle.

-- Logical pixels (scale-aware). Full height is derived from the monitor.
local SINGLE_WINDOW_WIDTH = 1900

---@type table<integer, integer>
local counts = {}

---@type table<string, integer>
local win_ws = {}

-- Workspace id → address of the window we put into solo pseudo mode.
---@type table<integer, string>
local narrowed = {}

---@param w HL.Window|nil
---@return boolean
local function is_countable(w)
    return w ~= nil
        and not w.floating
        and not w.hidden
        and (w.fullscreen == nil or w.fullscreen == 0)
end

---@param ws HL.Workspace|nil
---@param exclude_addr string|nil
---@return HL.Window[]
local function tiled_windows(ws, exclude_addr)
    local wins = {}
    if not ws then return wins end
    for _, w in ipairs(ws:get_windows()) do
        if w.address ~= exclude_addr and is_countable(w) then
            wins[#wins + 1] = w
            win_ws[w.address] = ws.id
        end
    end
    return wins
end

---@param win HL.Window|nil
local function pseudo_off(win)
    if not win then return end
    hl.dispatch(hl.dsp.window.pseudo({ action = "off", window = win }))
end

---@param win HL.Window
local function apply_narrow(win)
    local mon = win.monitor
    if not mon then return end

    local height = math.floor(mon.height / mon.scale)
    local ws = win.workspace
    if ws then
        narrowed[ws.id] = win.address
    end

    hl.dispatch(hl.dsp.window.pseudo({ action = "on", window = win }))
    hl.dispatch(hl.dsp.window.resize({
        x = SINGLE_WINDOW_WIDTH,
        y = height,
        relative = false,
        window = win,
    }))
    hl.dispatch(hl.dsp.window.center({ window = win }))
end

---@param ws_id integer
local function clear_narrowed(ws_id)
    local addr = narrowed[ws_id]
    narrowed[ws_id] = nil
    if not addr then return end
    pseudo_off(hl.get_window("address:" .. addr))
end

---@param ws HL.Workspace|nil
---@param exclude_addr string|nil
local function sync_workspace(ws, exclude_addr)
    if not ws or ws.special then return end

    local id = ws.id
    local prev = counts[id] or 0
    local wins = tiled_windows(ws, exclude_addr)
    local curr = #wins
    counts[id] = curr

    if curr == 1 and (prev == 0 or prev > 1) then
        apply_narrow(wins[1])
    elseif prev == 1 and curr ~= 1 then
        -- Left solo (0 or 2+): only disable the window we narrowed.
        clear_narrowed(id)
    end
end

local function seed_counts()
    counts = {}
    win_ws = {}
    narrowed = {}
    for _, ws in ipairs(hl.get_workspaces()) do
        if not ws.special then
            local wins = tiled_windows(ws)
            counts[ws.id] = #wins
        end
    end
end

hl.on("window.open", function(w)
    if not w then return end
    local ws = w.workspace
    if ws then
        win_ws[w.address] = ws.id
    end
    sync_workspace(ws)
end)

hl.on("window.close", function(w)
    if not w then return end
    local addr = w.address
    local ws = w.workspace
    local prev_id = win_ws[addr]
    win_ws[addr] = nil

    if ws then
        sync_workspace(ws, addr)
    elseif prev_id then
        sync_workspace(hl.get_workspace(prev_id), addr)
    end
end)

hl.on("window.move_to_workspace", function(w, dest_ws)
    if not w then return end
    local addr = w.address
    local prev_id = win_ws[addr]
    local dest = dest_ws or w.workspace

    if prev_id and (not dest or prev_id ~= dest.id) then
        sync_workspace(hl.get_workspace(prev_id), addr)
    end

    if dest then
        win_ws[addr] = dest.id
        sync_workspace(dest)
    end
end)

hl.on("hyprland.start", seed_counts)
hl.on("config.reloaded", seed_counts)

seed_counts()
