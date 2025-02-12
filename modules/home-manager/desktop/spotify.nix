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
        src = pkgs.fetchFromGitHub {
          owner = "fl3xm3ist3r";
          repo = "spicetifyExtensions/upcomingSong";
          rev = "5babaccf955724b0de1f0029cbdc328c35f95bf4";
          hash = "sha256-lTeyxzJNQeMdu1IVdovNMtgn77jRIhSybLdMbTkf2Ww=";
        };
        name = "upcomingSong.js";
      }

      {
        src = pkgs.fetchFromGitHub {
          owner = "sanoojes";
          repo = "spicetify-extensions/LibX-Reborn/src";
          rev = "64195000bceb0fe55a4aa5faafcc51136b5e3046";
          hash = "sha256-lTeyxzJNQeMdu1IVdovNMtgn77jRIhSybLdMbTkf2Ww=";
        };
        name = "LibX-Reborn.js";
      }

      {
        src = pkgs.fetchFromGitHub {
          owner = "BitesizedLion";
          repo = "AnonymizedRadios";
          rev = "1741f9ba19fe5e20183b3e65210ed6dec3bac17d";
          hash = "sha256-lTeyxzJNQeMdu1IVdovNMtgn77jRIhSybLdMbTkf2Ww=";
        };
        name = "AnonymizedRadios.js";
      }

    ];

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      betterLibrary

      {
        src = pkgs.fetchurl {
          url = "https://github.com/Pithaya/spicetify-apps-dist/archive/refs/heads/dist/eternal-jukebox.zip";
          hash = "sha256-RITnQXU1K6dBtER0ukfivbzRBG5rc/MeWkzOqJaYtYk=";
        };
        name = "eternal-jukebox";
      }

      {
        src = pkgs.fetchFromGitHub {
          owner = "ohitstom";
          repo = "spicetify-extensions/toggleDJ";
          rev = "065887ef6f31c35809a9dab035341606c1153cb5";
          hash = "sha256-lTeyxzJNQeMdu1IVdovNMtgn77jRIhSybLdMbTkf2Ww=";
        };
        name = "toggleDJ.js";
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

    theme = lib.mkForce (if config.visual.tui_theme then spicePkgs.themes.text else spicePkgs.themes.comfy);
    colorScheme = lib.mkForce "custom";
    customColorScheme = {
      button = colors.base0D;
      button-active = colors.base0E;
      button-disabled = colors.base04;
      card = colors.base02;
      heart = colors.base0F;
      highlight = colors.base03;
      highlight-elevated = colors.base04;
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

