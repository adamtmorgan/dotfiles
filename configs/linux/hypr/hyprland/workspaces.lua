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

-- No class→workspace rule: 1Password also shows transient auth prompts (e.g. SSH)
-- that should stay on the current workspace, not pull open special:1password.

--------------------------------------------------
--- Comms Workspace (Discord)
--------------------------------------------------

hl.workspace_rule({
  workspace = "special:comms",
  on_created_empty = apps.discord,
  persistent = true,
})

hl.window_rule({
  match = { class = apps.class.discord },
  workspace = "special:comms",
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

-- Grok (Brave PWA) → scratchpad when opened
hl.window_rule({
  match = { class = apps.class.grok },
  workspace = "special:scratchpad",
})
