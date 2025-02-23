{ pkgs, ...}:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    taps = [
      "FelixKratz/formulae"
      "nikitabobko/tap"
      "vladdoster/formulae"
    ];

    brews = [
      "borders"
    ];

    casks = [
      "kitty"
      "docker"
      "aerospace"
      "vimari"
      "android-studio"
      "rider"
    ];
  };
}
