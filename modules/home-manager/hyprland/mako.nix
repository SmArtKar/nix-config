# mako.nix

{ pkgs, inputs, config, lib, ... }:

# Mako notification daemon

let
  colors = config.lib.stylix.colors.withHashtag;
in {
  services.mako = {
    enable = true;
    sort = "-time";
    backgroundColor = "${colors.base00}96";
    borderColor = "${colors.base0E}C8";
    borderRadius = 4;
    borderSize = 2;
    defaultTimeout = 15000;
    margin = "10,10,5";
    font = "${config.visual.makoFont} 11";
    progressColor = "source ${colors.base0E}C8";
    textColor = "${colors.base06}";
    width = 320;
    extraConfig = ''
    format=<b>%s</b>\n%b

    [grouped]
    format=<b>%s (%g)</b>\n%b

    [urgency=low]
    border-color=${colors.base0D}C8

    [urgency=high]
    border-color=${colors.base08}C8
    default-timeout=0
    
    [category=spotify]
    default-timeout=3000

    [category=mpd]
    group-by=category

    [category=discord]
    default-timeout=10000
    group-by=none
    '';
  };
}
