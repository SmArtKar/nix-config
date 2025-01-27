# waybar.nix

{ pkgs, inputs, config, lib, ... }:

# Waybar panel

let
  colorNames = [
    "base00"
    "base01"
    "base02"
    "base03"
    "base04"
    "base05"
    "base06"
    "base07"
    "base08"
    "base09"
    "base0A"
    "base0B"
    "base0C"
    "base0D"
    "base0E"
    "base0F"
  ];

  # Colors used in the markup
  colors = config.lib.stylix.colors.withHashtag;
  
  color_base = colors.base00;
  mantle = colors.base01;
  surface0 = colors.base02;
  surface1 = colors.base03;
  surface2 = colors.base04;
  color_text = colors.base05;
  rosewater = colors.base06;
  lavender = colors.base07;
  red = colors.base08;
  peach = colors.base09;
  yellow = colors.base0A;
  green = colors.base0B;
  teal = colors.base0C;
  blue = colors.base0D;
  mauve = colors.base0E;
  flamingo = colors.base0F;

  defineColor = name: value: "@define-color ${name} ${value};";
  markup = color: text: "<span color=\"${color}\" style=\"oblique\">${text}</span>";
in {
  programs.waybar = {
    enable = true;
    
    settings.main = {
      layer = "top";
      position = "top";
      output = [
        "DP-1"
      ];
      #height = 24;

      modules-left = [
        # "backlight"
        "custom/launcher"
        # "temperature"
        "hyprland/workspaces"
        "hyprland/window"
      ];

      modules-center = [
        #"custom/playerctl"
      ];

      modules-right = [
        # "mpd"
        "pulseaudio"
        "network"
        "battery"
        "idle_inhibitor"
        "tray"
        #"hyprland/language"
        "clock"
      ];

      "custom/launcher" = {
        format = " ";
        tooltip = false;
      };

      "hyprland/workspaces" = {
        all-outputs = true;
      };

      "hyprland/window" = {
        format = "{initialTitle}";
        rewrite = {
          "kitty" = "󰄛 Kitty";
          "Mozilla Firefox" = "󰈹 Firefox";
          "Telegram" = " Telegram";
          "Discord" = " Discord";
          "Spotify.*" = " Spotify";
        };
      };

      temperature = {
        critical-threshold = 80;
        format = " {temperatureC}°C";
        format-critical = " {temperatureC}°C";
        tooltip = false;
      };

      mpd = {
        interval = 2;
        unknown-tag = "N/A";
        format = "{stateIcon} {artist} - {title}";
        format-disconnected = "󱘖 Disconnected";
        format-paused = "{stateIcon} {artist} - {title}";
        format-stopped = "Stopped  ";
        state-icons = {
          playing = " ";
          paused = " ";
        };
        tooltip-format = "MPD (connected)";
        tooltip-format-disconnected = "MPD (disconnected)";
        on-click = "mpc toggle";
        on-click-middle = "mpc prev";
        on-click-right = "mpc next";
        on-update = "";
        on-scroll-up = "mpc seek +00:00:01";
        on-scroll-down = "mpc seek -00:00:01";
        smooth-scrolling-threshold = 1;
      };

      pulseaudio = {
        format = "{icon}{volume}%";
        format-muted = "  Mute";
        format-bluetooth = "󰂯 {volume}% {format_source}";
        format-bluetooth-muted = "󰂯 Mute";
        format-source = " {volume}%";
        format-source-muted = " ";
        format-icons = {
          headphone = " ";
          hands-free = "󱡏 ";
          headset = " ";
          phone = " ";
          portable = " ";
          car = " ";
          default = [ " " " " " " ];
        };
        on-click = "amixer set Master toggle";
        on-click-right = "pavucontrol";
        smooth-scrolling-threshold = 1;
      };

      network = {
        interval = 5;
        format-wifi = "${markup green " "} {essid}";
        format-ethernet = "${markup green " "}{ipaddr}/{cidr}";
        format-linked = "${markup yellow " "}{ifname} (No IP)";
        format-disconnected = "${markup red "󱘖 "}Disconnected";
        format-alt = "${markup green " "}{bandwidthUpBytes} | ${markup mauve " "}{bandwidthDownBytes}";
        tooltip-format = "${markup green " "}{ifname} via {gwaddr}";
        on-click-middle = "nm-connection-editor";
        on-click-right = "kitty nmtui";
      };

      battery = {
        interval = 10;
        states = {
          warning = 30;
          critical = 15;
        };
        max-length = 20;
        format = "{icon} {capacity}%";
        format-warning = "{icon} {capacity}%";
        format-critical = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-full = " {capacity}%";
        format-icons = [ " " " " " " " " " " ];
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = " ";
          deactivated = " ";
        };
        tooltip = false;
      };

      clock = {
        interval = 60;
        format = " {:%H:%M}";
        format-alt = " {:%H:%M, %a %b %d, %G}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months =   "<span color='#ffead3'><b>{}</b></span>";
            days =     "<span color='#ecc6d9'><b>{}</b></span>";
            weeks =    "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today =    "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
      };

      tray = {
        icon-size = 15;
        spacing = 5;
      };
    };

    style = lib.strings.concatStringsSep "\n"
    (
      # Convert the colors attribute set to GTK color declarations
      builtins.map (color: defineColor color colors.${color}) colorNames
    )
    +
    (builtins.readFile ./../../../configs/waybar/style.css)
    +
    # Stylix monospace font
    ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
      }
    ''; 
  };
}
