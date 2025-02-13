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

  baseValues = [
    "0" "1" "2" "3"
    "4" "5" "6" "7"
    "8" "9" "A" "B"
    "C" "D" "E" "F"
  ];

in {
  
  options = {
    visual.tuiTheme = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    visual.colorScheme = lib.mkOption {
      type = lib.types.path;
      default = ./../../configs/stylix/needles_saturated.yaml;
    };

    visual.waybarFont = lib.mkOption {
      type = lib.types.str;
      default = config.stylix.fonts.monospace.name;
    };

    visual.makoFont = lib.mkOption {
      type = lib.types.str;
      default = config.stylix.fonts.sansSerif.name;
    };

    visual.hyprswitchFont = lib.mkOption {
      type = lib.types.str;
      default = config.stylix.fonts.sansSerif.name;
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

      image = pkgs.runCommand "lutgen_background.png" { } ''
        ${builtins.concatStringsSep "\n" (builtins.map (value: "COLOR${value}=$(${pkgs.yq}/bin/yq -r .palette.base0${value} ${theme})") baseValues)}
        ${pkgs.lutgen}/bin/lutgen apply -o $out ${wallpaper} -- ${builtins.concatStringsSep " " (builtins.map (value: "$COLOR${value}") baseValues)} 
      '';

      opacity = {
        applications = 0.95;
        desktop = 0.95;
        popups = 0.90;
        terminal = 0.90;
      };

      targets = {
        spicetify.enable = false;
      };

      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };

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
