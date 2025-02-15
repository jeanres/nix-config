{
	programs.wezterm = {
		enable = true;
		extraConfig = ''
			return {
				hide_tab_bar_if_only_one_tab = true,
window_decorations = "RESIZE",
				color_scheme = "rose-pine", -- or Macchiato, Frappe, Latte
				font = wezterm.font('JetBrains Mono', { }),
				font_size = 18,
			}
		'';
	};
}
