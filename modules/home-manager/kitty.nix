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
      "ctrl+enter" = "send_text normal,application \x1b[13;5u";
      "shift+enter" = "send_text normal,application \x1b[13;2u";
      "ctrl+tab" = "send_text normal,application \x1b[9;5u";
      "ctrl+shift+tab" = "send_text normal,application \x1b[9;6u";
    };

    settings = {
      enable_audio_bell = false;
      tab_bar_edge = "top";
    };
  };
}
