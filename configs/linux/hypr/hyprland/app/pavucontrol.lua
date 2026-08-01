local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

local M = {
  key = "audio_settings",
  cmd = uwsm("pavucontrol"),
  class = "org.pulseaudio.pavucontrol",
}

function M.setup()
  hl.bind(mods.open_app .. " + A", hl.dsp.exec_cmd(M.cmd))

  -- Float, centered, same size as resizeMod+1 (25% x 70%)
  hl.window_rule({
    match = { class = M.class },
    float = true,
    center = true,
    size = { "(monitor_w*0.25)", "(monitor_h*0.7)" },
  })
end

return M
