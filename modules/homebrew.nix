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
      "microsoft-teams"
      "slack"
      "aerospace"
      "vimari"
      "font-jetbrains-mono-nerd-font"
      "orcaslicer@nightly"
      "creality-print"
      "whatsapp"
      "discord"
      "utm"
      "obs"
    ];
  };
}
