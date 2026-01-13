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
      "reattach-to-user-namespace"
      "opencode"
    ];

    casks = [
      "kitty"
      "docker-desktop"
      "aerospace"
      "font-jetbrains-mono-nerd-font"
      "slack"
      "obs"
      "whatsapp"
    ];
  };
}
