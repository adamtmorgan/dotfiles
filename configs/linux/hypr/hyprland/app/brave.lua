local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

local M = {
  key = "browser",
  cmd = uwsm("brave"),
  class = "brave-browser",
}

function M.setup()
  hl.bind(mods.open_app .. " + B", hl.dsp.exec_cmd(M.cmd))
end

return M
