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

