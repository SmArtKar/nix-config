# hyprland

{ pkgs, inputs, config, lib, ... }:

# Hyprland WM

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

  defineColor = name: value: "@define-color ${name} ${value};";

  colors = config.lib.stylix.colors.withHashtag;
  hyprswitchConfig = pkgs.writeText "hyprswitchConfig.css" (lib.strings.concatStringsSep "\n"
    (
      # Convert the colors attribute set to GTK color declarations
      builtins.map (color: defineColor color colors.${color}) colorNames
    )
    +
    (builtins.readFile ./../../../configs/hyprswitch/style.css)
    +
    # Stylix monospace font
    ''
      * {
        font-family: "${config.visual.hyprswitchFont}";
      }
    ''
  );
in {
  imports = 
  [
    # Kitty is required by default
    ./../kitty.nix
    # Daemons and utilities
    ./packages.nix
    ./hyprlock.nix
    ./wlogout.nix
    ./mako.nix
    ./rofi.nix

    ./waybar.nix
  ];
  
  home.packages = with pkgs; [
    hyprshot
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    inputs.pyprland.packages.x86_64-linux.pyprland
    hyprpicker
    slurp
    grim
    libnotify
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "mako"
        "systemctl --user start hyprpolkitagent"
        "waybar --bar main --log-level error"
        "hyprswitch init --show-title --size-factor 4 --workspaces-per-row 5 --custom-css ${hyprswitchConfig}"
        "pypr --config ${./../../../configs/pyprland/config.toml}"
      ]; 

      # --------
      #  Inputs
      # --------

      input = {
        kb_layout = "us, ru";
        kb_options = "grp:alt_shift_toggle";
        
	      follow_mouse = true;
	      mouse_refocus = false;
        natural_scroll = false;
      };

      # ------------------
      #  Monitor settings
      # ------------------

      monitor = [
        "DP-1, 1920x1080, 0x0, 1"
	      "eDP-1, 1920x1200, 1920x-120, 1"
      ];
      
      # ----------
      #  Programs
      # ----------

      "$terminal" = "kitty";
      "$terminalFloat" = "kitty --title kitty-float";
      "$terminalFloatPin" = "kitty --title kitty-float-pin";
      "$menu" = "rofi -show drun";
      "$cliphist" = "rofi-cliphist";
      "$pass" = "$HOME/.local/bin/scripts/keepassxc -d /home/smartkar/secrets/master.kdbx";
      "$fileManager" = "kitty --title kitty-float yazi";
      "$fileManagerAlt" = "thunar";
      "$visualizer" = "kitty --title cava-float cava";
      "$browser" = "zen";
      "$logout" = "wlogout -p layer-shell";

      # ---------
      #  General
      # ---------
      
      general = {
	      gaps_in = 5;
	      gaps_out = 10;

      	border_size = 0;

        resize_on_border = true;
        allow_tearing = true;
      	layout = "dwindle";
      };

      # ---------
      #  Visuals
      # ---------

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
	      inactive_opacity = 0.93;
	      fullscreen_opacity = 1.0;

	      shadow = {
          enabled = true;
          ignore_window = true;
	        range = 16;
	        render_power = 3;
          color = lib.mkForce "rgba(${config.lib.stylix.colors.base00}FF)";
          color_inactive = lib.mkForce "rgba(${config.lib.stylix.colors.base00}FF)";
	      };

	      blur = {
	        enabled = true;
	        size = 8;
	        passes = 3;
	        vibrancy = 0.1696;
	        ignore_opacity = true;
          new_optimizations = true;
          noise = 0.0117;
          contrast = 1.4;
          brightness = 1;
          xray = false;
	      };
      };

      dwindle = {
        pseudotile = true;
	      preserve_split = true;
      };

      # ------------
      #  Animations
      # ------------

      animations = {
        enabled = true;
        animation = [
          "windows, 1, 5, default, popin 80%"
	        "windowsOut, 1, 7, default, popin 80%"
	        "border, 1, 10, default"
	        "fadeOut, 1, 8, default"
	        "fadeIn, 1, 8, default"
	        "workspaces, 1, 6, default"
	      ];
      };
      
      # -------------
      #  Keybindings
      # -------------

      "$mod" = "SUPER";

      bind = [
        # Core binds
	      "$mod, Q, exec, $terminal"
	      "$mod SHIFT, Q, exec, $terminalFloat"
	      "$mod, R, exec, $menu"
	      "$mod CTRL, C, exec, $cliphist"
	      "$mod SHIFT, R, exec, $pass"
	      "$mod, B, exec, $browser"
	      "$mod SHIFT, B, exec, $browser --private-window"
	      "$mod, E, exec, $fileManager"
	      "$mod SHIFT, E, exec, $fileManagerAlt"
        "$mod, M, exec, $visualizer"
	      "$mod, C, killactive"
	      "$mod, X, exec, $logout"
        "$mod, F, fullscreen"
        "$mod, Space, togglefloating"
        "$mod, P, exec, pkill waybar || waybar --bar main"
        "$mod SHIFT, P, exec, hyprpicker -a"
        "$mod CTRL, M, exec, playerctl --player playerctld next"

        # Screenshots
        ", Print, exec, hyprshot -z -m output -o ~/Pictures/Screenshots -- imv"
        "SHIFT, Print, exec, hyprshot -z -m window -o ~/Pictures/Screenshots -- imv"
        "CTRL, Print, exec, hyprshot -z -m region -o ~/Pictures/Screenshots --imv"

        # Focus movement
	      "$mod, left, movefocus, l"
	      "$mod, right, movefocus, r"
	      "$mod, up, movefocus, u"
	      "$mod, down, movefocus, d"

        # Window movement
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, l"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Resizing windows
        "$mod CTRL, left, resizeactive, -20 0"
        "$mod CTRL, right, resizeactive, 20 0"
        "$mod CTRL, up, resizeactive, 0 -20"
        "$mod CTRL, down, resizeactive, 0 20"

        # Workspace scrolling

	      "$mod, mouse_up, workspace, e-1"
	      "$mod, mouse_down, workspace, e+1"
        "$mod CTRL, left, workspace, e-1"
        "$mod CTRL, right, workspace, e+1"

        # 10th workspace
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scratchpad
        "$mod, grave, togglespecialworkspace"
        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod CTRL, Q, exec, pypr toggle term"

        # Hyprswitch
        "ALT, tab, exec, hyprswitch gui --filter-current-monitor --mod-key alt_l --key tab --close mod-key-release --reverse-key=key=grave && hyprswitch dispatch"
        "ALT, grave, exec, hyprswitch gui --filter-current-monitor --mod-key alt_l --key tab --close mod-key-release --reverse-key=key=grave && hyprswitch dispatch -r"
      ]
      ++ (
        # Workspace binds
	      builtins.concatLists (builtins.genList (i:
	        let ws = i + 1;
	        in if i < 5 then [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
	          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            "$mod CTRL, code:1${toString i}, workspace, ${toString (ws + 5)}"
	          "$mod CTRL SHIFT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
            "$mod CTRL, P, moveworkspacetomonitor, ${toString ws} DP-1"
	        ] else [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
	          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            "$mod CTRL, P, moveworkspacetomonitor, ${toString ws} eDP-1"
          ]
        )
	      9)
      );

      bindm = [
	      # Mouse movements
	      "$mod, mouse:272, movewindow"
	      "$mod, mouse:273, resizewindow"
	      "$mod ALT, mouse:272, resizewindow"
      ];

      windowrulev2 = [
        "float, class:(yad)"
        "float, class:(org\.pulseaudio\.pavucontrol)"
        "float, class:(feh|imv|Gpicview)"
        "float, class:(qemu)"
        "float, class:(nm-connection-editor)"
        "float, class:(\.blueman-manager-wrapped)"
        "float, class:(firefox), title:(Library)"

        "float, class:(kitty), title:(nmtui)"
        "size 30% 50%, class:(kitty), title:(nmtui)"

        "float, class:(kitty), title:(kitty-float.*)"
        "move onscreen cursor -50% -50%, class:(kitty), title:(kitty-float.*)"
        "size 60% 60%, class:(kitty), title:(kitty-float.*)"
        "pin, class:(kitty), title:(kitty-float-pin)"

        "float, class:(kitty), title:(cava-float)"
        "size 40% 40%, class:(kitty), title:(cava-float)"
        "suppressevent fullscreen maximize, class:(kitty), title:(cava-float)"
        "pin, class:(kitty), title:(cava-float)"
        "move 100%-w-15 100%-w-15, class:(kitty), title:(cava-float)"

        # Functional Picture-in-Picture
        "float, class:(firefox), title:(Picture-in-Picture)"
        "suppressevent fullscreen maximize, class:(firefox), title:(Picture-in-Picture)"
        "pin, class:(firefox), title:(Picture-in-Picture)"
        "move 100%-w-15 100%-w-15, class:(firefox), title:(Picture-in-Picture)"

        # Wlogout handling
        "float, class:(wlogout)"
        "move 0 0, class:(wlogout)"
        "size 100% 100%, class:(wlogout)"
        "animation slide, class:(wlogout)"

        # Telegram voice call handling
        "float, class:(org.telegram.desktop), title:(^(?!.*Telegram).*$)"
        "pin, class:(org.telegram.desktop), title:(^(?!.*Telegram).*$)"

        # Workspace ordering
        # "workspace 1, class:(kitty)"
        # "workspace 2, class:(firefox)"
        # "workspace 3, class:(VSCodium)"
        # "workspace 3, class:(Code)"
        "workspace 4, class:(discord)"
        "workspace 5, class:(org.telegram.desktop)"
        # "workspace 6, class:(firefox)"
        "workspace 7, class:(Spotify)"
        "workspace 9, class:(net.lutris.Lutris)"
        "workspace 9, class:(steam), title:(Steam)"

        # Opacity rules
        # Per stylix config, terminals already have reduced opacity
        "opacity 1.0 override 0.97 override, class:(kitty)"
        # Transparent dark mode apps look... questionable
        "opacity 1.0 override 0.95 override, class:(discord)"
        "opacity 1.0 override 0.95 override, class:(org.telegram.desktop)"

        # Games
        "fullscreen, class:^steam_app.*"
        "maximize, class:^steam_app.*"
        "monitor DP-1, class:^steam_app.*"
        "workspace 10, class:^steam_app.*"
        "fullscreen, title:(.*Big Picture.*)"
        "maximize, title:(.*Big Picture.*)"
        "monitor DP-1, title:(.*Big Picture.*)"
        "workspace 10, title:(.*Big Picture.*)"
        "float, class:(steam), title:(Special Offers)"
        "float, class:(steam), title:(^(?!.*Steam).*$)"
      ];

      workspace = [
        "1, monitor:DP-1, default:true, persistant:true"
        "2, monitor:DP-1, default:true, persistant:true"
        "3, monitor:DP-1, default:true, persistant:true"
        "4, monitor:DP-1, default:true, persistant:true"
        "5, monitor:DP-1, default:true, persistant:true"
        "6, monitor:eDP-1, default:true, persistant:true"
        "7, monitor:eDP-1, default:true, persistant:true"
        "8, monitor:eDP-1"
        "9, monitor:eDP-1"
        # Workspace 10 holds games
        "10, monitor:DP-1"
      ];

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      layerrule = [
        "blur, rofi"
        "blur, waybar"
        "ignorezero, rofi"
        "ignorezero, waybar"
      ];
    };
    
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
  };

  home.sessionVariables = {
    # Fixes cursor issues
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hints electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # Firefox should also run on wayland
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    # Correct java execution
    _JAVA_AWT_WM_NOREPARENTING = "1";
    # QT styling and wayland
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland";
    # Drivers
    SDL_VIDEODRIVER = "wayland";
    GDK_BACKEND = "wayland";
  };
}

