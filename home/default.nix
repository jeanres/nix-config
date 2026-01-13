{ inputs, pkgs, ... }:

{
  imports = [
    ./core.nix
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./neovim.nix
  ];

  home = {
    homeDirectory = "/Users/jeanres";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  programs.pandoc.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.fd.enable = true;

  programs.htop.enable = true;

  programs.yazi.enable = true;

  xdg.configFile = {
    "nvim" = {
      source = ./config/neovim;
      recursive = true;
    };
  };

  xdg.configFile = {
    "kitty" = {
      source = ./config/kitty;
      recursive = true;
    };
  };
  xdg.configFile = {
    "yazi" = {
      source = ./config/yazi;
      recursive = true;
    };
  };

  xdg.configFile = {
    "aerospace" = {
      source = ./config/aerospace;
      recursive = true;
    };
  };
}
