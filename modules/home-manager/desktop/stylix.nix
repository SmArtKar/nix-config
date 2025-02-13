# stylix.nix

{ pkgs, inputs, lib, ... }:

# home-manager version of stylix file - only configures some targets for stylix

{
  stylix.targets = {
    nixvim.enable = true;
    btop.enable = true;
    cava.enable = true;
    waybar.enable = false;
    nixcord.enable = false;
    spicetify.enable = false;
    mako.enable = false;
    firefox.enable = false;
  };
}
