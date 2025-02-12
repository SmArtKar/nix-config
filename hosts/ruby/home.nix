# home.nix

{ pkgs, inputs, config, lib, ... }:

# Device-specific home-manager configuration

{
  imports =
  [
    ./../../modules/home-manager/core.nix
    ./../../modules/home-manager/media.nix

    ./../../modules/home-manager/hyprland
    ./../../modules/home-manager/nixvim

    ./../../modules/home-manager/shell/cava.nix
    ./../../modules/home-manager/shell/discordo.nix

    ./../../modules/home-manager/desktop/rofi.nix
    ./../../modules/home-manager/desktop/stylix.nix
    ./../../modules/home-manager/desktop/telegram.nix
    ./../../modules/home-manager/desktop/discord.nix
    ./../../modules/home-manager/desktop/spotify.nix
    ./../../modules/home-manager/desktop/vscode.nix
  ];

  config = {
    home.username = "smartkar";
    home.homeDirectory = "/home/smartkar";

    home.stateVersion = "24.05";

    home.packages = with pkgs; [

      # -------------------
      #  Font Installation
      # -------------------

      noto-fonts
      noto-fonts-emoji
      corefonts
      vistafonts
      cascadia-code
      dina-font
      fira-code-symbols
      fira-sans
      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
      nerd-fonts.agave
      nerd-fonts.arimo
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.inconsolata
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu-sans

      # --------
      #  Themes
      # --------

    ];

    home.file = {
      ".local/bin/scripts" = {
        source = ./../../modules/scripts;
        recursive = true;
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.home-manager.enable = true;
    fonts.fontconfig.enable = true;
  };
}
