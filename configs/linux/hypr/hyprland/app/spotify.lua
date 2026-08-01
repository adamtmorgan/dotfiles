local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

-- Brave PWA: ~/.local/share/applications/brave-pjibgclleladliembfgfagdaldikeohf-Default.desktop
local exec =
  "/opt/brave-bin/brave --profile-directory=Default --app-id=pjibgclleladliembfgfagdaldikeohf"

local M = {
  key = "spotify",
  cmd = uwsm(exec),
  class = "brave-pjibgclleladliembfgfagdaldikeohf-Default",
}

function M.setup()
  hl.bind(mods.open_app .. " + M", hl.dsp.exec_cmd(M.cmd))

  hl.window_rule({
    match = { class = M.class },
    workspace = "special:media",
  })
end

return M
