{ ... }:

{
  imports = [
    ./core.nix
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./kitty.nix
    ./neovim.nix
    ./aerospace.nix
  ];

  home = {
    homeDirectory = "/Users/jeanre.swanepoel";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.htop.enable = true;
  programs.yazi.enable = true;
  programs.irssi.enable = true;
}
