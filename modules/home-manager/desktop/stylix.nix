# stylix.nix

{ pkgs, inputs, lib, ... }:

# home-manager version of stylix file - only configures some targets for stylix

{
  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus Light";
      dark = "Papirus Dark";
    };

    targets = {
      nixvim.enable = true;
      nixvim.transparentBackground = {
        main = true;
        signColumn = true;
      };
      btop.enable = true;
      cava.enable = true;
      waybar.enable = false;
      nixcord.enable = false;
      spicetify.enable = false;
      mako.enable = false;
      firefox = {
        enable = true;
        profileNames = [ "smartkar" ];
      };
    };
  };
}
