local wezterm = require("wezterm")

local solarized_dark = wezterm.color.get_builtin_schemes()["Solarized Dark (base16)"]
solarized_dark.tab_bar = {
	background = "#002b36",
	active_tab = {
		bg_color = "#002b36",
		fg_color = "#fdf6e3",
		intensity = "Bold",
	},

	inactive_tab = {
		bg_color = "#002b36",
		fg_color = "#586e75",
		italic = true,
	},

	inactive_tab_hover = {
		bg_color = "#002b36",
		fg_color = "#fdf6e3",
		italic = false,
		intensity = "Bold",
	},

	new_tab = {
		bg_color = "#002b36",
		fg_color = "#586e75",
	},

	new_tab_hover = {
		bg_color = "#002b36",
		fg_color = "#fdf6e3",
	},
}
solarized_dark.cursor_bg = "#2aa198"
solarized_dark.cursor_fg = "#fdf6e3"
solarized_dark.selection_bg = "#475b62"
solarized_dark.selection_fg = "#002831"

return {
	color_schemes = {
		["Solarized Dark"] = solarized_dark,
	},
	color_scheme = "Solarized Dark",
	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" }),
	font_size = 14,
	initial_rows = 1000,
	initial_cols = 1000,
	window_decorations = "RESIZE",
	window_padding = {
		left = "2cell",
		right = "2cell",
		top = "1cell",
		bottom = "1cell",
	},
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 800,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	audible_bell = "Disabled",
}
