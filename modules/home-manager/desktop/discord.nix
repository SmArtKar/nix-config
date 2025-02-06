# vesktop.nix

{ pkgs, inputs, lib, ... }:

# Fancy discord client, configured via nixcord

{ 
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];
  
  home.packages = with pkgs; [
    #vesktop
  ];

  programs.nixcord = {
    enable = true;
    discord.vencord.unstable = true;
    config = {
      frameless = true;
      transparent = true;
      themeLinks = [
        # "https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/flavors/spotify-text.theme.css"
        "https://raw.githubusercontent.com/xcruxiex/themes/refs/heads/master/themes-cores/nocturnal.css"
      ];
      enabledThemes = [
        # "stylix.theme.css"
      ];

      plugins = {
        accountPanelServerProfile.enable = true;
        alwaysAnimate.enable = true;
        alwaysTrust = {
          enable = true;
          file = true;
        };
        anonymiseFileNames.enable = true;
        betterGifAltText.enable = true;
        betterSettings.enable = true;
        betterUploadButton.enable = true;
        clearURLs.enable = true;
        dearrow = {
          enable = true;
          replaceElements = "titles";
        };
        decor.enable = true;
        experiments.enable = true;
        fakeNitro.enable = true;
        fakeProfileThemes.enable = true;
        fixCodeblockGap.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds  .enable = true;
        forceOwnerCrown.enable = true;
        gameActivityToggle.enable = true;
        messageLinkEmbeds.enable = true;
        noBlockedMessages.enable = true;
        noSystemBadge.enable = true;
        noTypingAnimation.enable = true;
        noUnblockToJump.enable = true;
        onePingPerDM.enable = true;
        openInApp.enable = true;
        replaceGoogleSearch = {
          enable = true;
          customEngineName = "DuckDuckGo";
          customEngineURL = "https://duckduckgo.com/?q=";
        };
        reverseImageSearch.enable = true;
        showConnections.enable = true;
        spotifyControls = {
          enable = true;
          useSpotifyUris = true;
        };
        spotifyCrack.enable = true;
        validUser.enable = true;
        volumeBooster.enable = true;
        youtubeAdblock.enable = true;
        webRichPresence.enable = true;
        webScreenShareFixes.enable = true;
      };
    };

    extraConfig = {

    };
  };
}
