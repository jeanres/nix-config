{ ... }:

{
  imports = [
    ./core.nix
    ./zsh.nix
    ./git.nix
    ./neovim.nix
    ./wezterm.nix	
  ];

  home = {
    homeDirectory = "/Users/jeanre.swanepoel";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
}
