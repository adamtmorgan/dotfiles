local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

local M = {
  key = "terminal",
  cmd = uwsm("ghostty"),
}

function M.setup()
  hl.bind(mods.open_app .. " + T", hl.dsp.exec_cmd(M.cmd))
end

return M
