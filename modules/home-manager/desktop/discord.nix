# discord.nix

{ pkgs, inputs, config, lib, ... }:

# Fancy discord client, configured via nixcord

let
  colorNames = [
    "base00"
    "base01"
    "base02"
    "base03"
    "base04"
    "base05"
    "base06"
    "base07"
    "base08"
    "base09"
    "base0A"
    "base0B"
    "base0C"
    "base0D"
    "base0E"
    "base0F"
  ];

  # Colors used in the markup
  colors = config.lib.stylix.colors.withHashtag;
  defineColor = name: value: "  --${name}: ${value};";
in {
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
      useQuickCss = true;
      frameless = true;
      transparent = true;
      themeLinks = 
      ( if config.visual.tuiTheme then [
        "https://refact0r.github.io/system24/theme/system24.theme.css"
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

    quickCss = ''
    :root {
    ${lib.strings.concatStringsSep "\n" (
        # Convert the colors attribute set to GTK color declarations
        builtins.map (color: defineColor color colors.${color}) colorNames
      )}
    }
    ''+ builtins.readFile ./../../../configs/discord/theme.css;

    extraConfig = {
      openasar = {
        setup = true;
        quickstart = true;
      };
      MINIMIZE_TO_TRAY = false;
    };
  };
}
