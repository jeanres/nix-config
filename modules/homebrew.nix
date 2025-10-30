{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
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
      "opencode"
    ];

    casks = [
      "kitty"
      "docker-desktop"
      "aerospace"
      "vimari"
      "font-jetbrains-mono-nerd-font"
      "slack"
      "microsoft-teams"
    ];
  };
}
