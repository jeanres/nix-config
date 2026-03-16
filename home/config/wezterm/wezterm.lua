local wezterm = require("wezterm")

return {
	font = wezterm.font("JetBrainsMono Nerd Font"),
	color_scheme = "Catppuccin Mocha",
	font_size = 16.0,
	window_decorations = "RESIZE",
	use_fancy_tab_bar = false,
	-- window_background_opacity = 0.98,
	hide_tab_bar_if_only_one_tab = true,
}
