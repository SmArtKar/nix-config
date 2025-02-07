# spotify.nix

{ pkgs, inputs, config, lib, ... }:

# Fancy spotify client

{
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

    };
  };
}

