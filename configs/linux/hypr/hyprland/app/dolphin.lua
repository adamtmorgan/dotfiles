local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

local M = {
  key = "file_manager",
  cmd = uwsm("dolphin"),
}

function M.setup()
  hl.bind(mods.open_app .. " + F", hl.dsp.exec_cmd(M.cmd))
end

return M
