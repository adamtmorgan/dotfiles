local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

local M = {
  key = "password_manager",
  cmd = "[float] " .. uwsm("1password --show"),
  class = "1password",
}

function M.setup()
  hl.bind(mods.open_app .. " + P", hl.dsp.exec_cmd(M.cmd))
  -- No class→workspace rule: transient auth prompts (e.g. SSH) should stay put.
end

return M
