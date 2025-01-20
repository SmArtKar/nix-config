# rofi.nix

{ pkgs, inputs, lib, ... }:

# Rofi Application Launcher

{
  programs.rofi = {
    enable = true;
    location = "top";
    font = "Fira-Code";

    theme = {
      "*" = {
        background = "#222222";
        foreground = "#F2F2F2";
        lightbg = "#161616";
        lightfg = "#F2F2F2";
        blue = "#aadb0f";
      };
      window = {
        border = 6;
        y-offset = -6;
        border-color = "#aadb0f";
      };
    };

    extraConfig = {
      modi = "combi";
      combi-modi = "run, filebrowser, window, ssh";
      terminal = "kitty";
    };
  };
}
