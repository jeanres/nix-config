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
  };

  outputs = { self, nixpkgs, darwin, home-manager}:
    {
    darwinConfigurations = {
      "Jeanres-Mac-Pro" = darwin.lib.darwinSystem {
	system = "x86_64-darwin"; # use "x86_64-darwin" on pre-M1 Mac
	  modules = [
	    ./systems/darwin.nix
	    {
	      users.users."jeanre".home = "/Users/jeanre";
	    }
	    home-manager.darwinModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users."jeanre" = import ./home;
	    }
	  ];
      };
      "Jeanres-MacBook-Pro" = darwin.lib.darwinSystem {
	system = "aarch64-darwin"; # use "x86_64-darwin" on pre-M1 Mac
	  modules = [
	    ./systems/darwin.nix
	    ./modules/homebrew.nix
	    {	
	      users.users."jeanre".home = "/Users/jeanre";
	    }
	    home-manager.darwinModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users."jeanre" = import ./home;
	    }
	  ];
      };
    };
  };
}
