{
  config,
  pkgs,
  lib,
  ...
}:

let
  vars = import ../shared/variables.nix;
in
{
  # Install sops for managing secrets
  home.packages = with pkgs; [
    sops
    age
  ];

  # Configure sops-nix
  sops = {
    # Path to your age key
    age.keyFile = "${vars.homeDirectory}/.config/sops/age/keys.txt";

    # Default sops file
    defaultSopsFile = ../secrets/secrets.yaml;

    # Validate that the sops file exists on activation
    validateSopsFiles = true;

    # Define your secrets here
    secrets = {
      # SSH private key (id_rsa)
      "ssh_id_rsa" = {
        path = "${vars.homeDirectory}/.ssh/id_rsa";
        mode = "0600";
      };
    };
  };

  # Fix PATH for sops-nix launchd service on macOS
  launchd.agents.sops-nix = lib.mkIf pkgs.stdenv.isDarwin {
    enable = true;
    config = {
      EnvironmentVariables = {
        PATH = lib.mkForce "/usr/bin:/bin:/usr/sbin:/sbin";
      };
    };
  };
}
