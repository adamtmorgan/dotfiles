local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

local M = {
  key = "discord",
  cmd = uwsm("discord"),
  class = "discord",
}

function M.setup()
  hl.bind(mods.open_app .. " + D", hl.dsp.exec_cmd(M.cmd))

  hl.window_rule({
    match = { class = M.class },
    workspace = "special:media",
  })
end

return M
