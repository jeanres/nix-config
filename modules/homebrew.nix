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
      "reattach-to-user-namespace"
    ];

    casks = [
      "kitty"
      "docker"
      "microsoft-teams"
      "slack"
      "aerospace"
      "vimari"
      "google-chrome"
      "android-studio"
      "postman"
      "font-jetbrains-mono-nerd-font"
      "utm"
      "tableplus"
    ];
  };
}
