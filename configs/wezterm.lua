-- Pull in the wezterm API and init objects
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Appearance ---------------------------------------------------

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold", italic = false })
-- config.freetype_load_flags = "NO_HINTING"
-- config.front_end = "OpenGL"
-- config.freetype_load_target = "Light"
-- config.freetype_render_target = "HorizontalLcd"
-- config.cell_width = 0.9
config.font_size = 12
-- config.line_height = 1.05

local bg = "#1c2125"
local fg = "#E2DCC0"

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
	background = bg,

	tab_bar = {
		inactive_tab_edge = "None",
		active_tab = {
			bg_color = bg,
			fg_color = fg,
		},
		inactive_tab = {
			bg_color = bg,
			fg_color = "#60687e",
		},
		inactive_tab_hover = {
			bg_color = bg,
			fg_color = fg,
			italic = true,
		},
		new_tab = {
			bg_color = bg,
			fg_color = fg,
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
		key = "j",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "|",
		mods = "CMD|SHIFT",
		action = act.SplitHorizontal({}),
	},
	{
		key = "-",
		mods = "CMD|SHIFT",
		action = act.SplitVertical({}),
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
