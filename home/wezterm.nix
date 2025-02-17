{
	programs.wezterm = {
		enable = true;
		extraConfig = ''
			return {
				hide_tab_bar_if_only_one_tab = true,
				window_decorations = "RESIZE",
				max_fps = 120,
				color_scheme = "rose-pine", -- or Macchiato, Frappe, Latte
				font_size = 16,
				window_padding  = { left = 10, right = 10, top = 10, bottom = 10 },
			}
		'';
	};
}
