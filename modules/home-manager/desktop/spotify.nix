# spotify.nix

{ pkgs, inputs, lib, ... }:

# Fancy spotify client

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
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

    theme = lib.mkForce spicePkgs.themes.text;
  };
}

