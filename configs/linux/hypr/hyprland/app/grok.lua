local uwsm = require("hyprland/app/_uwsm")
local mods = require("hyprland/mods")

-- Brave PWA: ~/.local/share/applications/brave-ggjocahimgaohmigbfhghnlfcnjemagj-Default.desktop
local exec =
  "/opt/brave-bin/brave --profile-directory=Default --app-id=ggjocahimgaohmigbfhghnlfcnjemagj"

local M = {
  key = "grok",
  cmd = uwsm(exec),
  class = "brave-ggjocahimgaohmigbfhghnlfcnjemagj-Default",
}

function M.setup()
  hl.bind(mods.open_app .. " + G", hl.dsp.exec_cmd(M.cmd))

  hl.window_rule({
    match = { class = M.class },
    workspace = "special:scratchpad",
  })
end

return M
