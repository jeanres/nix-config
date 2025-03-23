{ pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		package = pkgs.neovim-unwrapped;
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
