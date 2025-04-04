-- Pull in the wezterm API and init objects
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- Appearance ---------------------------------------------------

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold" })
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = false }),
	},
}
-- config.freetype_load_flags = "NO_HINTING"
-- config.freetype_load_target = "Light"
-- config.freetype_render_target = "HorizontalLcd"
config.font_size = 12
config.line_height = 1.2
config.underline_position = "-0.25cell"
config.adjust_window_size_when_changing_font_size = false

config.dpi_by_screen = {
	-- ['Built-in Retina Display'] = 144,
	["C49RG9x"] = 72,
}

-- Colors
config.color_scheme = "kanagawabones"

local bg = "#1b1e26"
local tabbar_bg = "#12141a"
local tabbar_active_bg = "#232530"
local fg = "#E2DCC0"
local fg_faded = "#60687e"

-- Added for when available in release

-- config.window_content_alignment = {
-- 	horizontal = "Center",
-- 	vertical = "Center",
-- }

-- Custom colors
-- config.force_reverse_video_cursor = true
config.colors = {
	cursor_bg = "#FF9E3B",
	cursor_border = "#FF9E3B",
	cursor_fg = "000000",
	background = bg,

	tab_bar = {
		inactive_tab_edge = "None",
		active_tab = {
			bg_color = tabbar_active_bg,
			fg_color = fg,
		},
		inactive_tab = {
			bg_color = tabbar_bg,
			fg_color = fg_faded,
		},
		inactive_tab_hover = {
			bg_color = bg,
			fg_color = fg,
			italic = true,
		},
		new_tab = {
			bg_color = "none",
			fg_color = fg_faded,
		},
		new_tab_hover = {
			bg_color = "none",
			fg_color = fg,
		},
	},
}

-- Tab bar styling
config.use_fancy_tab_bar = true
config.window_frame = {
	active_titlebar_bg = tabbar_bg,
	inactive_titlebar_bg = tabbar_bg,
	font_size = 12.0,
}

local x_padding = "7"
local y_padding = "8"
config.window_padding = {
	left = x_padding,
	right = x_padding,
	top = y_padding,
	bottom = y_padding,
}

-- Window settings
config.window_background_opacity = 0.97
config.macos_window_background_blur = 70
config.window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW"
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- Performance settings
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 120

-- Disable ligeratures
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Keymaps --------------------------------------------------------

config.leader = { key = "Space", mods = "CTRL" }

config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "h",
		mods = "CMD",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CMD",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "j",
		mods = "CMD",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CMD",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "j",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
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
	{
		key = "F",
		mods = "CMD|SHIFT",
		action = act.TogglePaneZoomState,
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.HideApplication,
	},

	-- Session bindings
	{ key = "s", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_session" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_session" }) },
	{ key = "r", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_session" }) },
}

-- Session Manager plugin ------------------------------------------------

local session_manager = require("wezterm-session-manager/session-manager")

wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)

return config
