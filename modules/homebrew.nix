{ pkgs, ...}:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
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
      "microsoft-teams"
      "slack"
      "aerospace"
      "vimari"
      "tableplus"
      "insomnia"
      "datagrip"
      "google-chrome"
<<<<<<< Updated upstream
=======
      "android-studio"
      "font-hack-nerd-font"
      "sf-symbols"
>>>>>>> Stashed changes
    ];
  };
}
