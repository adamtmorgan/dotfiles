-- =====================
-- Workspace Rules (Special / Scratchpad)
-- =====================

--------------------------------------------------
--- 1Password Space
--------------------------------------------------

hl.workspace_rule({
  workspace = "special:1password",
  on_created_empty = "[float] 1password --show",
  persistent = true,
})

--------------------------------------------------
--- Grok Space
--------------------------------------------------

local grok_cmd = "/opt/brave-bin/brave --profile-directory=Default --app-id=ggjocahimgaohmigbfhghnlfcnjemagj"

hl.workspace_rule({
  workspace = "special:grok",
  persistent = true,
  on_created_empty = grok_cmd,
})

hl.window_rule({
  -- IMPORTANT: actual class/title from `hyprctl clients`
  match = { class = "brave-ggjocahimgaohmigbfhghnlfcnjemagj-Default" },
  workspace = "special:grok",
  -- float = true,
  -- size = { x = 1200, y = 800 },
  -- center = true,
})

--------------------------------------------------
--- Scratchpad Space
--------------------------------------------------

hl.workspace_rule({
  workspace = "special:scratchpad",
  on_created_empty = "ghostty"
  -- You can also do "[float] foot" if you want everything floating here
})

-- Optional: Force floating + nice defaults on the scratchpad workspace
-- hl.window_rule({
--     match = { workspace = "special:scratchpad" },
--     float = true,
--     size = { 800, 600 },        -- optional fixed size
--     center = true,
-- })
