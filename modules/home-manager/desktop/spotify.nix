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
    ];

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      betterLibrary
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
      button = "89B4FA";
      button-active = "74C7EC";
      button-disabled = "45475A";
      card = "45475A";
      heart = "FAB387";
      highlight = "333645";
      highlight-elevated = "292A38";
      main = "181825";
      main-elevated = "232432";
      main-transition = "181825";
      misc = "585B70";
      notification = "89B4FA";
      notification-error = "F38BA8";
      pagelink-active = "FFFFFF";
      play-button = "F5C2E7";
      play-button-active = "F2CDCD";
      player = "181825";
      progress-bg = "45475A";
      progress-fg = "89DCEB";
      radio-btn-active = "74C7EC";
      selected-row = "BAC2DE";
      shadow = "585B70";
      sidebar = "1E1E2E";
      subtext = "BAC2DE";
      tab-active = "313244";
      text = "CDD6F4";

      /*
      button = "${colors.base0D}";
      button-active = "${colors.base0C}";
      button-disabled = "${colors.base03}";
      card = "${colors.base03}";
      heart = "${colors.base09}";
      highlight = "${colors.base02}";
      highlight-elevated = "${colors.base01}";
      main = "${colors.base00}";
      main-elevated = "${colors.base01}";
      main-transition = "${colors.base00}";
      misc = "${colors.base04}";
      notification = "${colors.base0D}";
      notification-error = "${colors.base08}";
      pagelink-active = "${colors.base07}";
      play-button = "${colors.base0E}";
      play-button-active = "${colors.base0A}";
      player = "${colors.base00}";
      progress-bg = "${colors.base03}";
      progress-fg = "${colors.base0C}";
      radio-btn-active = "${colors.base0C}";
      selected-row = "${colors.base05}";
      shadow = "${colors.base04}";
      sidebar = "${colors.base00}";
      subtext = "${colors.base05}";
      tab-active = "${colors.base02}";
      text = "${colors.base06}"; 
      */
    };
  };
}

