{ ... }:

{
  imports = [
    ./programs/zsh.nix
    ./programs/wezterm.nix
    ./programs/aerospace.nix
    ./programs/neovim.nix
    ./programs/aws.nix
    ./programs/yazi.nix
    ./programs/google-chrome.nix
    ./programs/tmux.nix
    ./programs/opencode.nix

    ./services/jankyborders.nix
  ];

  xdg.configFile = {
    "aerospace" = {
      source = ./config/aerospace;
      recursive = true;
    };
  };

  xdg.configFile = {
    "nvim" = {
      source = ./config/neovim;
      recursive = true;
    };
  };

  xdg.configFile = {
    "wezterm" = {
      source = ./config/wezterm;
      recursive = true;
    };
  };

}
