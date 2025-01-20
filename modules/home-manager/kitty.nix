# kitty.nix

{ config, pkgs, lib, ... }:

# Kitty configuration - required by hyprland

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

    # Keybinding consistency with other emulators
    keybindings = {
      "ctrl+shift+m" = "toggle_maximized";
      "ctrl+shift+f" = "show_scrollback"; # Search in current window
    };

    settings = {
      background_opacity = "0.93";
      enable_audio_bell = false;
      tab_bar_edge = "top";
    };
  };
}
