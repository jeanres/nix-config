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

  nixpkgs.config.permittedInsecurePackages = [
    "ruby-2.7.8"
  ];

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  system = {
    defaults = {
      dock = {
        mru-spaces = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
