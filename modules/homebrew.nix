{ pkgs, ...}:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    taps = [
      "vladdoster/formulae"
    ];

    brews = [
    ];

    casks = [
      "docker"
      "vimari"
      "obs"
      "obs-ndi"
      "tableplus"
      "microsoft-teams"
      "slack"
      "transmission"
    ];
  };
}
