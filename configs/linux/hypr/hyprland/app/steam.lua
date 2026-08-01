local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

local M = {
  key = "steam",
  cmd = uwsm("steam"),
  class = "steam",
}

function M.setup()
  hl.bind(mods.open_app .. " + S", hl.dsp.exec_cmd(M.cmd))
  hl.bind(mods.open_app .. " + SHIFT + S", hl.dsp.exec_cmd(M.cmd .. " -silent steam://open/gamepadui"))

  -- Float most Steam windows (Settings, game options, store, etc.)
  hl.window_rule({
    match = { class = M.class },
    float = true,
  })

  -- Keep the main Steam library window tiled
  hl.window_rule({
    match = { class = M.class, title = "Steam" },
    float = false,
  })

  -- Tile Friends List next to the library; shrink to ~1/8 width on open
  hl.window_rule({
    match = { class = M.class, title = "Friends List" },
    float = false,
  })

  hl.on("window.open", function(w)
    if not w or w.class ~= M.class or w.title ~= "Friends List" then return end
    local mon = w.monitor
    if not mon then return end
    -- mon.width is pixels; window geometry is logical (pixels / scale)
    local mon_w = mon.width / mon.scale
    local left_dist = w.at.x - mon.x
    local right_dist = mon.x + mon_w - (w.at.x + w.size.x)
    -- dwindle: left≈ratio/2, right≈(2-ratio)/2 → 0.25/1.75 ≈ 1/8
    local ratio = (right_dist < left_dist) and 1.75 or 0.25
    hl.dispatch(hl.dsp.layout("splitratio " .. ratio .. " exact"))
  end)

  hl.window_rule({
    match = { class = M.class, title = "Settings" },
    float = true,
  })

  hl.window_rule({
    match = { class = M.class, title = "Properties" },
    float = true,
  })

  -- Big Picture Mode
  hl.window_rule({
    match = {
      class = "^[Ss]team$",
      title = "^Steam Big Picture Mode$",
    },
    fullscreen = true,
    suppress_event = "fullscreen",
  })

  -- Retain Big Picture fullscreen after a game closes
  hl.on("window.active", function(w)
    if w and w.class == "steam" and w.title == "Steam Big Picture Mode" then
      hl.dispatch(hl.dsp.window.fullscreen({
        action = "set",
        mode = "fullscreen",
      }))
    end
  end)
end

return M
