-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
  -- No longer needed - handled via systemd
  -- hl.exec_cmd("awww-daemon")
  -- hl.exec_cmd("awww clear 000000")

  -- Prefer default theme for gnome UIs
  -- hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

  -- Clipboard support
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
