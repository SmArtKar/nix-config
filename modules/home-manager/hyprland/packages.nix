# packages.nix

{ pkgs, inputs, config, lib, ... }:

# Hyprland-related packages and daemons

{
  home.packages = with pkgs; [
    yad
    mpc-cli
    ncmpcpp
    networkmanagerapplet
    wf-recorder
    wl-clipboard
    hyprpicker
  ];
  
  # Mako notification daemon
  services.mako = {
    enable = true;
    sort = "-time";

    extraConfig = "
      max-history = 100;
    ";
  };
  
  # Automatic timeout
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpmson";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  
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

  programs.wlogout = {
    enable = true; 
  };
}
