-- Pull in the wezterm API and init objects
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Appearance ---------------------------------------------------

config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = false })

config.use_fancy_tab_bar = true
config.window_frame = {
	active_titlebar_bg = "#1C1E25",
	inactive_titlebar_bg = "#1C1E25",
	font_size = 12.0,
}

-- For example, changing the color scheme:
config.colors = {
	cursor_bg = "#FF9E3B",
	cursor_border = "#FF9E3B",
	cursor_fg = "000000",
	background = "#1B1E25",
	tab_bar = {
		inactive_tab_edge = "None",
		active_tab = {
			bg_color = "#3C3E50",
			fg_color = "#ffffff",
		},
		inactive_tab = {
			bg_color = "#1c2129",
			fg_color = "#DCD7BA",
		},
	},
}

config.window_background_opacity = 0.90
config.macos_window_background_blur = 50
config.window_decorations = "RESIZE"

-- Keymaps --------------------------------------------------------

config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "|",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
}

-- and finally, return the configuration to wezterm
return config
