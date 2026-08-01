-- https://wiki.hypr.land/Configuring/Start/
-- Alternate entry (package-relative requires). Prefer ../hyprland.lua as primary.

require("autostart")
require("behavior")
require("cursor")
require("env")
require("input")
require("apps")
require("keybindings")
require("monitor")
require("permissions")
require("style")
require("workspaces")

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})
