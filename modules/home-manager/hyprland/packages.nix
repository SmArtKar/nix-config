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
    bluez
    bluez-tools
    inputs.hyprswitch.packages.x86_64-linux.default
    inputs.rofi-tools.packages.${pkgs.system}.rofi-cliphist
  ];

  services.cliphist = {
    enable = true;
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

  services.kdeconnect = {
    enable = true;
  };
}
