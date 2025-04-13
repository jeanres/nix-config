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
      "google-chrome"
      "font-fantasque-sans-mono-nerd-font"
    ];
  };
}
