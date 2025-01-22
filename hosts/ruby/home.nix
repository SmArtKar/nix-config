# home.nix

{ config, pkgs, inputs, lib, ... }:

# Device-specific home-manager configuration

{
  imports =
  [
    ./../../modules/home-manager/hyprland.nix
    inputs.anyrun.homeManagerModules.default
    # ./../../modules/home-manager/anyrun.nix
    ./../../modules/home-manager/rofi.nix
    ./../../modules/home-manager/git.nix
  ];

  home.username = "smartkar";
  home.homeDirectory = "/home/smartkar";

  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    wget
    neovim
    fastfetch

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

    (nerdfonts.override { fonts = [
      "0xproto"
      "DroidSansMono"
      "Agave"
      "Arimo"
      "DroidSansM"
      "FiraCode"
      "FiraMono"
      "Inconsolata"
      "Iosevka"
      "JetBrainsMono"
      "Noto"
      "Ubuntu"
      "UbuntuMono"
      "UbuntuSans"
    ]; })

    # --------
    #  Themes
    # --------
  
  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
}
