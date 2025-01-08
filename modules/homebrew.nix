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
      "docker"
      "slack"
      "microsoft-teams"
      "obs"
    ];
  };
}
