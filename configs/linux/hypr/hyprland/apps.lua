-- Shared app launch commands and window classes for Hyprland config modules.
-- Prefer `uwsm app` so launches land in app-graphical.slice under UWSM.

local function uwsm(cmdline)
  return "uwsm app -- " .. cmdline
end

-- Brave PWAs under ~/.local/share/applications/brave-*-Default.desktop
local grok_exec =
  "/opt/brave-bin/brave --profile-directory=Default --app-id=ggjocahimgaohmigbfhghnlfcnjemagj"
local spotify_exec =
  "/opt/brave-bin/brave --profile-directory=Default --app-id=pjibgclleladliembfgfagdaldikeohf"

return {
  terminal = uwsm("ghostty"),
  file_manager = uwsm("dolphin"),
  browser = uwsm("brave"),
  menu = "hyprlauncher",
  steam = uwsm("steam"),
  password_manager = "[float] " .. uwsm("1password --show"),
  discord = uwsm("discord"),
  audio_settings = uwsm("pavucontrol"),
  grok = uwsm(grok_exec),
  spotify = uwsm(spotify_exec),

  class = {
    discord = "discord",
    onepassword = "1password",
    grok = "brave-ggjocahimgaohmigbfhghnlfcnjemagj-Default",
    spotify = "brave-pjibgclleladliembfgfagdaldikeohf-Default",
  },
}
