# stylix.nix

{ pkgs, inputs, lib, ... }:

# Stylix style manager - core module, some additional stuff is in home-manager modules file

let
  theme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";
  wallpaper = pkgs.fetchurl {
      url = "https://github.com/Lalit64/dotfiles/blob/main/home/lalit/modules/wallpapers/catppuccin-fauna.png?raw=true";
      sha256 = "sha256-4nFo0PPlESqoFWZhEtA9JvFnOChOIxxcZq/FqiYNfCw=";
    };
in {
  stylix = {
    enable = true;
    autoEnable = true; 

    polarity = "dark";
    base16Scheme = theme;
    image = wallpaper;

    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 0.97;
      terminal = 0.97;
    };

    targets = {

    };
  };
}
