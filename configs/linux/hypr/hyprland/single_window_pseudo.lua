-- NOTE: AI-authored

-- When a normal workspace transitions to exactly one tiled window (0→1 or >1→1),
-- enable pseudo tiling and shrink to a fixed logical width at full height.
-- Leaving solo (1→2+) disables pseudo on that window so normal tiling resumes.

local utils = require("hyprland/utils")
local resize = require("hyprland/resize")

---@type table<integer, integer>
local counts = {}

---@type table<string, integer>
local win_ws = {}

-- Workspace id → address of the window we put into solo pseudo mode.
---@type table<integer, string>
local narrowed = {}

--- Remember which workspace each countable window currently lives on.
---@param ws HL.Workspace
---@param wins HL.Window[]
local function track_windows(ws, wins)
    for _, w in ipairs(wins) do
        win_ws[w.address] = ws.id
    end
end

---@param win HL.Window
local function apply_narrow(win)
    local ws = win.workspace
    if ws then
        narrowed[ws.id] = win.address
    end

    utils.pseudo_on(win)
    resize.solo(win)
end

---@param ws_id integer
local function clear_narrowed(ws_id)
    local addr = narrowed[ws_id]
    narrowed[ws_id] = nil
    if not addr then return end
    utils.pseudo_off(hl.get_window("address:" .. addr))
end

---@param ws HL.Workspace|nil
---@param exclude_addr string|nil
local function sync_workspace(ws, exclude_addr)
    if not ws or ws.special then return end

    local id = ws.id
    local prev = counts[id] or 0
    local wins = utils.tiled_windows(ws, exclude_addr)
    track_windows(ws, wins)
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
            local wins = utils.tiled_windows(ws)
            track_windows(ws, wins)
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
