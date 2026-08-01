-- App registry: loads per-app modules, runs setup(), exports a flat API.
-- Usage: local apps = require("hyprland/apps")
--        apps.discord, apps.class.discord, …
-- Modules live in hyprland/app/ (singular) to avoid clashing with this package name.
--
-- NOTE: parenthesize require() — it returns a second value that would otherwise
-- pollute the array constructor (classic Lua gotcha).

local modules = {
  (require("hyprland/app/ghostty")),
  (require("hyprland/app/dolphin")),
  (require("hyprland/app/brave")),
  (require("hyprland/app/hyprlauncher")),
  (require("hyprland/app/steam")),
  (require("hyprland/app/onepassword")),
  (require("hyprland/app/discord")),
  (require("hyprland/app/pavucontrol")),
  (require("hyprland/app/grok")),
  (require("hyprland/app/spotify")),
}

local export = { class = {} }

for _, mod in ipairs(modules) do
  assert(type(mod) == "table" and mod.key, "app module missing key: " .. tostring(mod))
  export[mod.key] = mod.cmd
  if mod.class then
    export.class[mod.key] = mod.class
  end
  mod.setup()
end

return export
