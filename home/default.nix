{ ... }:

{
  imports = [
    ./core.nix
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./neovim.nix
    ./kitty.nix
    ./aerospace.nix
  ];

  home = {
    homeDirectory = "/Users/jeanre.swanepoel";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
}
