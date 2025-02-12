# wlogout.nix

{ pkgs, inputs, config, lib, ... }:

# Logout menu

let
  colors = config.lib.stylix.colors;
in {
  programs.wlogout = {
    enable = true;
    style = ''
      * {
        font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        transition: 20ms;
        font-size: 1.02em;
        box-shadow: none;
      }

      window {
        font-size: 16pt;
        background-color: rgba(${colors.base00-rgb-r}, ${colors.base00-rgb-g}, ${colors.base00-rgb-b}, 0.8);
      }

      button {
        background-color: rgba(${colors.base03-rgb-r}, ${colors.base03-rgb-g}, ${colors.base03-rgb-b}, 0.3);
        animation: gradient_f 20s ease-in infinite;
        border-radius: 20px;
        border: 3px solid ${colors.withHashtag.base05};
        margin: 10px;
        transition: all 0.2s cubic-bezier(.55, 0.0, .28, 1.682), box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 22%;
      }

      button:focus,
      button:active,
      button:hover {
        background-color: rgba(${colors.base01-rgb-r}, ${colors.base01-rgb-g}, ${colors.base01-rgb-b}, 0.9);
        border-color: ${colors.withHashtag.base0E};
        box-shadow: 0 -5px 20px ${colors.withHashtag.base00};
        background-size: 25%;
      }
      
      #lock {
        background-image: image(url("${./../../../configs/wlogout/lock.png}"));
      }
      
      #logout {
        background-image: image(url("${./../../../configs/wlogout/logout.png}"));
      }
      
      #suspend {
        background-image: image(url("${./../../../configs/wlogout/suspend.png}"));
      }
      
      #hibernate {
        background-image: image(url("${./../../../configs/wlogout/hibernate.png}"));
      }
      
      #shutdown {
        background-image: image(url("${./../../../configs/wlogout/shutdown.png}"));
      }
      
      #reboot {
        background-image: image(url("${./../../../configs/wlogout/reboot.png}"));
      }
    '';

    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Log Out";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Restart";
        keybind = "r";
      }
    ];
  };
}
