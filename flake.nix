# flake.nix
{
  description = "NixOS Config Flake";

  # Only affects the flake, need to add anyrun's cachix server
  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
    ];

    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = { 
    # Official NixOS packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Unstable NixOS channel
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    
    jujutsu.url = "github:jj-vcs/jj";
    stylix.url = "github:danth/stylix";
    
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Commit lock on agenix
    agenix.url = "github:ryantm/agenix/e600439ec4c273cf11e06fe4d9d906fb98fa097c";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in
  {
    nixosConfigurations = {
      ruby = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
	      modules = [
	        # Stylix imported in master flake for bootloader access
	        inputs.stylix.nixosModules.stylix
          ./hosts/ruby/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
	      ];
      };
    };
  };
}

