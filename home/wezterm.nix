{
	programs.wezterm = {
		enable = true;
		extraConfig = ''
			return {
				hide_tab_bar_if_only_one_tab = true,
				color_scheme = 'Oxocarbon Dark (Gogh)',
				font = wezterm.font('JetBrains Mono', { }),
				font_size = 20,
			}
		'';
	};
}
