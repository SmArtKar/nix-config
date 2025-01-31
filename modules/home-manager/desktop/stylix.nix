# stylix.nix

{ pkgs, inputs, lib, ... }:

# home-manager version of stylix file - only configures some targets for stylix

{
  stylix.targets = {
    nixvim.enable = true;
    btop.enable = true;
    waybar.enable = false;
  };
}
