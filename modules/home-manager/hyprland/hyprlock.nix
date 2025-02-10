# hyprlock.nix

{ pkgs, inputs, config, lib, ... }:

{
  # Lock screen
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        disable_loading_bar = true;
      };

      background = {
        path = lib.mkForce "screenshot";
        blur_passes = 3;
        blur_size = 8;
      };

      input-field = {
        shadow_passes = 2;
        rounding = 16;
        size = "300, 90";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        font_family = config.stylix.fonts.monospace.name;
        placeholder_text = "<i>Input Password...</i>";
        fade_on_empty = false;
        hide_input = false;
        position = "0, -120";
        halign = "center";
        valign = "center";
      };

      label = {
        text = "Hi there, $USER";
        font_size = 25;
        font_family = config.stylix.fonts.monospace.name;
        position = "0, -10";
        halign = "center";
        valign = "center";
        shadow_passes = 2;
      };

      image = {
        path = "$HOME/.face";
        size = 350;
        border_color = lib.mkForce "$accent";
        rounding = -1;
        position = "0, 75";
        halign = "center";
        valign = "center";
        shadow_passes = 2;
      };
    };
  };
}
