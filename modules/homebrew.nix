{ pkgs, ...}:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    taps = [
      "homebrew/cask-fonts"
      "vladdoster/formulae"
    ];

    brews = [
    ];

    casks = [
      "docker"
      "vimari"
    ];
  };
}
