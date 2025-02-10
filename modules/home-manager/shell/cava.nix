# cava.nix

{ pkgs, inputs, config, lib, ... }:

# Cava audio visualizer

let
  # Colors used in the markup
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 60;
      input.method = "pulse";
      smoothing.noise_reduction = 66;
      output.fragment_shader = "northern_lights.frag";
      color = {
        gradient = 3;
        gradient_color_1 = "${colors.base0D}";
        gradient_color_2 = "${colors.base0E}";
        gradient_color_3 = "${colors.base0F}";
      };
    };
  };
}
