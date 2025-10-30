{ inputs, pkgs, ... }:

{
  imports = [
    ./core.nix
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./kitty.nix
    ./neovim.nix
    ./aerospace.nix
    ./opencode.nix
  ];

  home = {
    homeDirectory = "/Users/jeanre";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
  programs.htop.enable = true;
  programs.yazi.enable = true;
}
