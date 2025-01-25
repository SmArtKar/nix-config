# kitty.nix

{ config, pkgs, lib, ... }:

# Kitty configuration - required by hyprland

{
  imports = [
    ./shell
  ];

  programs.kitty = {
    enable = true;

    # Keybinding consistency with other emulators
    keybindings = {
      "ctrl+shift+m" = "toggle_maximized";
      "ctrl+shift+f" = "show_scrollback"; # Search in current window
    };

    settings = {
      enable_audio_bell = false;
      tab_bar_edge = "top";
    };
  };
}
