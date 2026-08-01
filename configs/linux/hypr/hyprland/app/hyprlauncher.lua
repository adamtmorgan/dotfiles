local mods = require("hyprland/mods")

local M = {
  key = "menu",
  cmd = "hyprlauncher",
}

function M.setup()
  hl.bind(mods.main .. " + SPACE", hl.dsp.exec_cmd(M.cmd))
end

return M
