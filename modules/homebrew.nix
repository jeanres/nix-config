{ pkgs, ...}:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    taps = [
      "vladdoster/formulae"
    ];

    brews = [
    ];

    casks = [
      "vimari"
      "amethyst"
    ];
  };
}
