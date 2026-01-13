{
  description = "Jeanre's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      sops-nix,
    }:
    let
      vars = import ./shared/variables.nix;
    in
    {
      darwinConfigurations = {
        "Jeanres-Mac-Pro" = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./systems/darwin.nix
            {
              users.users.${vars.username}.home = vars.homeDirectory;
            }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${vars.username} = import ./home;
              home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];
            }
          ];
        };
        "Jeanres-MacBook-Pro" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./systems/darwin.nix
            ./modules/homebrew.nix
            {
              users.users.${vars.username}.home = vars.homeDirectory;
            }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${vars.username} = import ./home;
              home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];
            }
          ];
        };
      };
    };
}
