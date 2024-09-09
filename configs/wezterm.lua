-- Pull in the wezterm API and init objects
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Appearance ---------------------------------------------------

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = false })
config.font_size = 12

-- Tab bar styling
config.use_fancy_tab_bar = true
config.window_frame = {
	active_titlebar_bg = "#1c2125",
	inactive_titlebar_bg = "#1c2125",
	font_size = 12.0,
}

-- Custom colors
config.colors = {
	cursor_bg = "#FF9E3B",
	cursor_border = "#FF9E3B",
	cursor_fg = "000000",
	background = "#1c2125",

	tab_bar = {
		inactive_tab_edge = "None",
		active_tab = {
			bg_color = "#1c2125",
			fg_color = "#E2DCC0",
		},
		inactive_tab = {
			bg_color = "#1c2125",
			fg_color = "#60687e",
		},
		new_tab = {
			bg_color = "#1c2125",
			fg_color = "#E2DCC0",
		},
	},
}

-- Window settings
config.window_background_opacity = 0.97
config.macos_window_background_blur = 70
config.window_decorations = "RESIZE"

-- Misc other settings

-- Disable ligeratures
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

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
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = ")",
		mods = "CMD|SHIFT",
		action = act.MoveTabRelative(1),
	},
	{
		key = "(",
		mods = "CMD|SHIFT",
		action = act.MoveTabRelative(-1),
	},
}

return config