# flake.nix

{
  description = "NixOS Config Flake";

  # Only affects the flake, need to add anyrun's cachix server
  nixConfig = {
    extra-substituters = [
      "https://anyrun.cachix.org"
      "https://hyprland.cachix.org"
    ];

    extra-trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = { 
    # Official NixOS packages, 25 unstable has systemd issues
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # Unstable NixOS channel
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    
    # Anyrun runner/launcher
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jujutsu.url = "github:jj-vcs/jj";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, anyrun, jujutsu, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations = {
      ruby = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
	modules = [
          ./hosts/ruby/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          {
	    environment.systemPackages = [
              anyrun.packages.${system}.anyrun
	    ];
	  }
	];
      };
    };
  };
}

