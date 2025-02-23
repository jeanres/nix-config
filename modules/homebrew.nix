{ pkgs, ...}:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    brews = [
    ];

    casks = [
      "kitty"
      "rectangle"
      "docker"
      "microsoft-teams"
      "slack"
    ];
  };
}
