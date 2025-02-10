# stylix.nix

{ pkgs, inputs, config, lib, ... }:

# Stylix style manager - core module, some additional stuff is in home-manager modules file

let
  #theme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
  #theme = ./../../configs/stylix/needles_saturated.yaml;

  wallpaper = pkgs.fetchurl {
    #url = "https://4kwallpapers.com/images/wallpapers/frieren-ultrawide-5040x2160-15153.jpg";      
    #sha256 = "sha256-poYxAAsTaP7NEIKAWXIL/RuaOce0KG67ylCC540+pzg=";
    url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimg.uhdpaper.com%2Fwallpaper%2Ffrieren-sousou-no-frieren-588%401%40n-pc-4k.jpg&f=1&nofb=1&ipt=ef9c3ffef72bc634aef5e870e616fe23a242ebf3430adbe38832937c437d47ec&ipo=images";
    sha256 = "sha256-a9I609bk92qO5P1H+Jq75DFXbxsk+qwgG3B86ywvAGI=";
  };

in {
  
  options = {
    visual.tui_theme = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    visual.colorScheme = lib.mkOption {
      type = lib.types.path;
      default = ./../../configs/stylix/needles_saturated.yaml;
    };
  };
  
  config = {
    stylix = let
      theme = config.visual.colorScheme;
    in {
      enable = true;
      autoEnable = true; 

      polarity = "dark";
      base16Scheme = theme;
      image = pkgs.runCommand "lutgen-background.png" { } ''
        COLOR0=$(${pkgs.yq}/bin/yq -r .palette.base00 ${theme})
        COLOR1=$(${pkgs.yq}/bin/yq -r .palette.base01 ${theme})
        COLOR2=$(${pkgs.yq}/bin/yq -r .palette.base02 ${theme})
        COLOR3=$(${pkgs.yq}/bin/yq -r .palette.base03 ${theme})
        COLOR4=$(${pkgs.yq}/bin/yq -r .palette.base04 ${theme})
        COLOR5=$(${pkgs.yq}/bin/yq -r .palette.base05 ${theme})
        COLOR6=$(${pkgs.yq}/bin/yq -r .palette.base06 ${theme})
        COLOR7=$(${pkgs.yq}/bin/yq -r .palette.base07 ${theme})
        COLOR8=$(${pkgs.yq}/bin/yq -r .palette.base08 ${theme})
        COLOR9=$(${pkgs.yq}/bin/yq -r .palette.base09 ${theme})
        COLORA=$(${pkgs.yq}/bin/yq -r .palette.base0A ${theme})
        COLORB=$(${pkgs.yq}/bin/yq -r .palette.base0B ${theme})
        COLORC=$(${pkgs.yq}/bin/yq -r .palette.base0C ${theme})
        COLORD=$(${pkgs.yq}/bin/yq -r .palette.base0D ${theme})
        COLORE=$(${pkgs.yq}/bin/yq -r .palette.base0E ${theme})
        COLORF=$(${pkgs.yq}/bin/yq -r .palette.base0F ${theme})
        ${pkgs.lutgen}/bin/lutgen apply -o $out ${wallpaper} -- $COLOR0 $COLOR1 $COLOR2 $COLOR3 $COLOR4 $COLOR5 $COLOR6 $COLOR7 $COLOR8 $COLOR9 $COLORA $COLORB $COLORC $COLORD $COLORE $COLORF
      '';

      opacity = {
        applications = 0.95;
        desktop = 0.95;
        popups = 0.90;
        terminal = 0.90;
      };

      targets = {

      };

      fonts = {
        /*
        serif = {
          package = pkgs.nerd-fonts.inconsolata;
          name = "Inconsolata Nerd Font";
        };

        sansSerif = {
          package = pkgs.nerd-fonts.arimo;
          name = "Arimo Nerd Font";
        };
        */

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
