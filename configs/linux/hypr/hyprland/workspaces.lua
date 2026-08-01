-- =====================
-- Workspace Rules (Special / Scratchpad)
-- =====================

local apps = require("hyprland/apps")

--------------------------------------------------
--- 1Password Space
--------------------------------------------------

hl.workspace_rule({
  workspace = "special:1password",
  on_created_empty = apps.password_manager,
  persistent = true,
})

-- No class→workspace rule for 1Password: see app/onepassword.lua

--------------------------------------------------
--- Media Workspace (Discord, Spotify, etc.)
--------------------------------------------------

hl.workspace_rule({
  workspace = "special:media",
  on_created_empty = apps.discord,
  persistent = true,
})

--------------------------------------------------
--- Scratchpad Space - Usually an AI chat with
--- other random things.
--------------------------------------------------

hl.workspace_rule({
  workspace = "special:scratchpad",
  on_created_empty = apps.terminal,
  persistent = true,
})
