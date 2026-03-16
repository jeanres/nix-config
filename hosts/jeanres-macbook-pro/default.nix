{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      extra-platforms = x86_64-darwin
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  services.openssh.enable = true;

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    brews = [
      "reattach-to-user-namespace"
    ];

    casks = [
      "utm"
      "docker-desktop"
      "slack"
      "whatsapp"
      "font-fira-code-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "obs"
    ];
  };

  system = {
    primaryUser = "jeanre";
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  ids.gids.nixbld = 350;

  system.stateVersion = 5;
}
