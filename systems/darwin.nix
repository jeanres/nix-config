{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixVersions.latest;

    # Build optimization settings
    settings = {
      # Use all available cores for building
      max-jobs = "auto";
      cores = 0; # 0 means use all available cores

      # Enable additional binary caches for faster downloads
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      # Keep build artifacts for faster rebuilds
      keep-derivations = true;
      keep-outputs = true;
    };

    # Use nix-darwin's optimise option instead of auto-optimise-store
    optimise = {
      automatic = true;
    };

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

  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = "jeanres";

  security.sudo.extraConfig = ''
    jeanres ALL=(ALL:ALL) NOPASSWD: ALL
  '';

  services.openssh.enable = true;

  system.stateVersion = 6;

  programs.zsh.enable = true;

  system = {
    defaults = {
      NSGlobalDomain = {
      };
      screencapture = {
        location = "~/Documents/Screenshots";
      };
      dock = {
        mru-spaces = false;
        autohide = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
