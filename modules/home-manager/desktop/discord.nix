# discord.nix

{ pkgs, inputs, config, lib, ... }:

# Fancy discord client, configured via nixcord

{ 
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
    ./../../nixos/stylix.nix
  ];

  home.packages = with pkgs; [
    #vesktop # Enable vesktop instead of nixcord breaks once more
  ];

  programs.nixcord = {
    enable = true;
    discord.vencord.unstable = true;
    config = {
      frameless = true;
      transparent = true;
      themeLinks = 
      ( if config.visual.tuiTheme then [
        "https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/flavors/spotify-text.theme.css"
      ] else [
      
      ])
        ++ 
      [
        "https://raw.githubusercontent.com/Overimagine1/old-discord-font/refs/heads/main/source.css"
      ];

      enabledThemes = [
        "stylix.theme.css"
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
      openasar = {
        setup = true;
        quickstart = true;
      };
      MINIMIZE_TO_TRAY = false;
    };
  };
}
