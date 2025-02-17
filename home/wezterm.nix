{
	programs.wezterm = {
		enable = true;
		extraConfig = ''
			return {
				hide_tab_bar_if_only_one_tab = true,
				window_decorations = "RESIZE",
				max_fps = 120,
				color_scheme = "rose-pine", -- or Macchiato, Frappe, Latte
				font_size = 14,
window_padding  { left = "1cell", right = "1cell", top = "0.5cell", bottom = 0 },
			}
		'';
	};
}
