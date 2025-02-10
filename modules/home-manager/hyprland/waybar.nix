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
  purple = colors.base0E;
  pink = colors.base0F;

  defineColor = name: value: "@define-color ${name} ${value};";
  markup = color: text: "<span color=\"${color}\" style=\"oblique\">${text}</span>";
in {
  programs.waybar = {
    enable = true;
    
    settings.main = {
      layer = "top";
      position = "top";
      output = [
        "eDP-1"
        "DP-1"
      ];

      modules-left = [
        "custom/launcher"
        # "group/launcher"
        # "temperature"
        "hyprland/workspaces"
        # "hyprland/window"
      ];

      modules-center = [
        "custom/playerctl-left"
        # "cava"
        "custom/playerctl"
        # "cava"
        "custom/playerctl-right"
      ];

      modules-right = [
        # "mpd"
        "pulseaudio"
        "network"
        "battery"
        #"idle_inhibitor"
        "tray"
        #"hyprland/language"
        "clock"
      ];

      "group/launcher" = {
        modules = [
          "custom/launcher"
          "user"
        ];
        orientation = "horizontal";
      };

      "custom/launcher" = {
        format = " ";
        tooltip = false;
        on-click = "sh $HOME/.local/bin/scripts/menu";
        on-click-middle = "exec default_wall";
        on-click-right = "exec wallpaper_random";
      };

      user = {
        format = "{user}";
      };

      "hyprland/workspaces" = {
        all-outputs = true;
        persistent_workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
        };
      };

      "hyprland/window" = {
        format = "{initialTitle}";
        rewrite = {
          "kitty" = "󰄛 Kitty";
          "Mozilla Firefox" = "󰈹 Firefox";
          "Telegram.*" = " Telegram";
          "Discord" = " Discord";
          "Spotify.*" = " Spotify";
        };
      };

      "custom/playerctl-left" = {
        format = "${markup teal "󰙣"}";
        on-click = "playerctl --player playerctld previous";
        on-scroll-down = "playerctl --player playerctld volume .05-";
        on-scroll-up = "playerctl --player playerctld volume .05+";
        tooltip = false;
      };

      cava = {
        config = "$HOME/.config/cava/config";
        data_format = "ascii";
        ascii_max_range = 9;
        bars = 8;
        bar_delimiter = 0;
        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        actions = {
          on-click-right = "mode";
        };
      };

      "custom/playerctl" = {
        format = "{icon}<span>{}</span>";
        return-type = "json";
        max-length = 55;
        exec = "playerctl --player playerctld -a metadata --format '{\"text\": \"  {{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        on-click = "playerctl --player playerctld play-pause";
        on-click-middle = "playerctl --player playerctld previous";
        on-click-right = "playerctl --player playerctld next";
        format-icons = {
          "Paused" = "${markup blue ""}";
          "Playing" = "${markup purple ""}";
          "Stopped" = "${markup red ""}";
        };
        on-scroll-down = "playerctl --player playerctld volume .05-";
        on-scroll-up = "playerctl --player playerctld volume .05+";
      };

      "custom/playerctl-right" = {
        format = "${markup teal "󰙡"}";
        on-click = "playerctl --player playerctld next";
        on-scroll-down = "playerctl --player playerctld volume .05-";
        on-scroll-up = "playerctl --player playerctld volume .05+";
        tooltip = false;
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
        on-click = "pavucontrol";
        on-click-right = "amixer set Master toggle";
        smooth-scrolling-threshold = 1;
        scroll-step = 5;
      };

      network = {
        interval = 5;
        format-wifi = "${markup green " "} {signalStrength}%";
        format-ethernet = "${markup green "󰈀 "}100%";
        format-disconnected = "${markup red "󱘖 "}0%";
        format-alt = "${markup green ""} {bandwidthUpBytes} | ${markup purple ""} {bandwidthDownBytes}";
        tooltip-format = "${markup green " "}{ifname} via {gwaddr}";
        tooltip-format-wifi = "${markup green " "} {essid}\n${markup green " "} {ifname} via {gwaddr}";
        tooltip-format-ethernet = "${markup green " "} {ipaddr}/{cidr}\n${markup green " "} {ifname} via {gwaddr}";
        tooltip-format-disconnected = "${markup red "󱘖 " } Disconnected\n${markup green " "} {ifname} via {gwaddr}";
        on-click-middle = "kitty --title nmtui nmtui";
        on-click-right = "nm-connection-editor";
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

      "hyprland/language" = {
        "format-en" = "en";
        "format-ru" = "ru";
      };

      clock = {
        interval = 60;
        format = " {:%H:%M}";
        format-alt = " {:%a, %b %d, %H:%M}";
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

      "group/power" = {
        drawer = {
          transition-duration = 500;
          children-class = "not-power";
          transition-left-to-right = false;
        };

        modules = [
          "custom/power"
          "custom/lock"
          "custom/quit"
          "custom/reboot"
        ];

        orientation = "vertical";
      };

      "custom/power" = {
        format = "";
        tooltip = false;
        on-click = "shutdown now";
      };

      "custom/quit" = {
        format = "󰗼";
        tooltip = false;
        on-click = "hynprctl dispatch exit";
      };
 
      "custom/lock" = {
        format = "󰍁";
        tooltip = false;
        on-click = "hyprlock";
      };

      "custom/reboot" = {
        format = "󰜉";
        tooltip = false;
        on-click = "reboot";
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
