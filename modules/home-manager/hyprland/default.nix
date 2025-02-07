# hyprland

{ pkgs, inputs, config, lib, ... }:

# Hyprland WM

{
  imports = 
  [
    # Kitty is required by default
    ./../kitty.nix
    # Daemons and utilities
    ./packages.nix

    ./waybar.nix
  ];
  
  home.packages = with pkgs; [
    hyprshot
    xdg-desktop-portal-hyprland
    hyprpolkitagent
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "mako"
        "waybar --bar main --log-level error"
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
      "$menu" = "rofi -show drun";
      "$fileManager" = "kitty --title yazi-float yazi";
      "$browser" = "firefox";
      "$logout" = "wlogout";

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
	        size = 4;
	        passes = 3;
	        vibrancy = 0.1696;
	        ignore_opacity = false;
          new_optimizations = true;
          noise = 0.0117;
          contrast = 1.2;
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
	      "$mod, R, exec, $menu"
	      "$mod, B, exec, $browser"
	      "$mod, E, exec, $fileManager"
	      "$mod, C, killactive"
	      "$mod, X, exec, $logout"
        "$mod, F, fullscreen"
        "$mod, S, pseudo"
        "$mod, Space, togglefloating"
        "$mod, P, exec, pkill waybar || waybar --bar main"

        # Screenshots
        ", Print, exec, hyprshot -m output -o ~/Pictures/Screenshots -- imv"
        "SHIFT, Print, exec, hyprshot -m window -o ~/Pictures/Screenshots -- imv"
        "CTRL, Print, exec, hyprshot -m region -o ~/Pictures/Screenshots --imv"

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
      ]
      ++ (
        # Workspace binds
	      builtins.concatLists (builtins.genList (i:
	        let ws = i + 1;
	        in if i < 5 then [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
	          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            "$mod CTRL, code:1${toString i}, workspace, ${toString (ws + 5)}"
	          "$mod CTRL SHIFT, code:1${toString i}, movetoworkspace, ${toString (ws + 5)}"
	        ] else [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
	          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
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

        "float, class:(kitty), title:(yazi-float)"
        "move onscreen cursor -50% -50%, class:(kitty), title:(yazi-float)"
        "size 60% 60%, class:(kitty), title:(yazi-float)"

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

        # Workspace ordering
        # "workspace 1, class:(firefox)"
        # "workspace 2, class:(kitty)"
        "workspace 3, class:(kitty), title:(yazi)"
        "workspace 4, class:(discord)"
        "workspace 5, class:(org.telegram.desktop)"
        # "workspace 6, class:(firefox)"
        "workspace 7, class:(Spotify)"

        # Opacity rules
        # Per stylix config, terminals are already 0.95 opacity
        "opacity 1.0 override 0.97 override, class:(kitty)"
        # Transparent dark mode apps look... questionable
        "opacity 1.0 override 0.95 override, class:(discord)"
        "opacity 1.0 override 0.95 override, class:(org.telegram.desktop)"
      ];

      workspace = [
        "1,monitor:DP-1,default:true,persistant:true"
        "2,monitor:DP-1,default:true,persistant:true"
        "3,monitor:DP-1,default:true,persistant:true"
        "4,monitor:DP-1,default:true,persistant:true"
        "5,monitor:DP-1,default:true,persistant:true"
        "6,monitor:eDP-1,default:true,persistant:true"
        "7,monitor:eDP-1,default:true,persistant:true"
        "8,monitor:eDP-1"
        "9,monitor:eDP-1"
        "10,monitor:eDP-1"
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

