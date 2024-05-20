{ ... }:
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
	};

	xdg.configFile = {
		"nvim/init.lua" = {
			source = ./neovim/init.lua;
		};
		"nvim/lua" = {
			source = ./neovim/lua;
			recursive = true;
		};
	};
}
