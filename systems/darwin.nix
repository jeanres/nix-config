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
      interval = { Weekday = 0; Hour = 0; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = "jeanre";

  security.sudo.extraConfig = ''
    jeanre ALL=(ALL:ALL) NOPASSWD: ALL
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
