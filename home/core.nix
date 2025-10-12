{
	home.shellAliases = {
		cd = "z";
	};
	programs.ripgrep.enable = true;
	programs.jq.enable = true;
	programs.eza = {
		enable = true;
	};
	programs.htop.enable = true;
	programs.fzf = {
		enable = true;
	};
	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.tealdeer.enable = true;
	xdg.configFile = {
		"scripts" = {
			source = ./scripts;
			recursive = true;
		};
	};
}
