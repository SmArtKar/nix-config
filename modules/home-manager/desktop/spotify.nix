# spotify.nix

{ pkgs, inputs, config, lib, ... }:

# Fancy spotify client

let
  colors = config.lib.stylix.colors;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./../../nixos/stylix.nix
  ];

  home.packages = with pkgs; [
    spotify-cli-linux
    mpdris2
  ];
  
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;
    experimentalFeatures = true;
    alwaysEnableDevTools = true;

    enabledExtensions = with spicePkgs.extensions; [
      # Official extensions
      autoSkipVideo
      keyboardShortcut
      shuffle
      trashbin
      webnowplaying

      # Community packages
      powerBar
      seekSong
      playlistIcons
      featureShuffle
      oldSidebar
      history
      lastfm
      adblock
      hidePodcasts

      {
        src = "${pkgs.fetchFromGitHub {
          owner = "sanoojes";
          repo = "spicetify-extensions";
          rev = "64195000bceb0fe55a4aa5faafcc51136b5e3046";
          hash = "sha256-L2Vz662amzEP0O1aLBqkcajk84M52cTjWLuWvl7D8Mg=";
        }}/LibX-Reborn/src";
        name = "LibX-Reborn.js";
      }

      {
        src = pkgs.fetchFromGitHub {
          owner = "BitesizedLion";
          repo = "AnonymizedRadios";
          rev = "1741f9ba19fe5e20183b3e65210ed6dec3bac17d";
          hash = "sha256-5zmr/pkMg9Na/LF5Y4U9ftfSKxF1HF3vhIMwLKt1Vr4=";
        };
        name = "AnonymizedRadios.js";
      }

      {
        src = "${pkgs.fetchFromGitHub {
          owner = "ohitstom";
          repo = "spicetify-extensions";
          rev = "065887ef6f31c35809a9dab035341606c1153cb5";
          hash = "sha256-OUHCJftUnFm9gFsBhjZbm/ArObSt7l6FDlNoWzsUfsQ=";
        }}/toggleDJ";
        name = "toggleDJ.js";
      }
    ];

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      betterLibrary

      {
        src = builtins.fetchGit {
          url = "https://github.com/Pithaya/spicetify-apps-dist.git";
          rev = "63fcfce9bac7de59ca9cd06908c63705c8611625";
          ref = "dist/eternal-jukebox";
        };
        name = "eternal-jukebox";
      }

      {
        src = pkgs.fetchFromGitHub {
          owner = "ECE49595-Team-6";
          repo = "EnhancifyInstall";
          rev = "5d40a98a378a778b6be5f8b68eb60a6884ba43b0";
          hash = "sha256-A2SeKr/b77vd+u61omJlWk4ohIsKoWchLugoulpdK3A=";
        };
        name = "Enhancify";
      }
    ];

    enabledSnippets = with spicePkgs.snippets; [
      roundedNowPlaying
      roundedImages
      smoothPlaylistRevealGradient
      removeConnectBar
      fixMainViewWidth
      fixProgressBar
      alwaysShowForward
      modernScrollbar
      removeRecentlyPlayed
      pointer
    ];

    theme = (if config.visual.tuiTheme 
      then (
        spicePkgs.themes.text
      ) else
      {
        name = "Comfy";
        src = "${pkgs.fetchFromGitHub {
          owner = "Comfy-Themes";
          repo = "Spicetify";
          rev = "b5fbe9f01feed5081b74b678076bed4a59801185";
          hash = "sha256-clq21blMlQVrt6h0tW3wdSMNAUPaOo10XExWofimK1o=";
        }}/Comfy";

        overwriteAssets = true;
        
        requiredExtensions = [
          {
            src = "${pkgs.fetchFromGitHub {
              owner = "Comfy-Themes";
              repo = "Spicetify";
              rev = "b5fbe9f01feed5081b74b678076bed4a59801185";
              hash = "sha256-clq21blMlQVrt6h0tW3wdSMNAUPaOo10XExWofimK1o=";
            }}/Comfy";
            name = "theme.js";
          }
        ];

        extraCommands = ''
          cat ${./../../../configs/spicetify/theme.script.js} >> ./Extensions/theme.js
        '';
      }
    );

    colorScheme = "Comfy";
    customColorScheme = {
      button = colors.base0D;
      button-active = colors.base0E;
      button-disabled = colors.base04;
      card = colors.base02;
      heart = colors.base0F;
      highlight = colors.base03;
      highlight-elevated = colors.base03;
      main = colors.base01;
      main-elevated = colors.base02;
      main-transition = colors.base01;
      misc = colors.base04;
      notification = colors.base0D;
      notification-error = colors.base08;
      pagelink-active = colors.base07;
      play-button = colors.base0E;
      play-button-active = colors.base0F;
      player = colors.base00;
      progress-bg = colors.base03;
      progress-fg = colors.base0E;
      radio-btn-active = colors.base0E;
      selected-row = colors.base04;
      shadow = colors.base01;
      sidebar = colors.base00;
      subtext = colors.base04;
      tab-active = colors.base03;
      text = colors.base06;
    };
  };
}

