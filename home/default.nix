{ ... }:

{
  imports = [
    ./core.nix
    ./zsh.nix
    ./git.nix
    ./neovim.nix
    ./wezterm.nix
    ./tmux.nix
  ];

  home = {
    homeDirectory = "/Users/jeanreswanepoel";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
}
