{ ... }:
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
      "datagrip"
      "google-chrome"
      "android-studio"
      "beekeeper-studio"
      "font-fantasque-sans-mono-nerd-font"
      "obs"
      "discord"
    ];
  };
}
