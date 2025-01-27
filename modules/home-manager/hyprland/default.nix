# hyprland

{ pkgs, inputs, lib, ... }:

# Hyprland WM

{
  imports = 
  [
    # Kitty is required by default
    ./../kitty.nix
    # Notification daemon
    ./../mako.nix

    ./waybar.nix
  ];
  
  home.packages = with pkgs; [
    hyprshot
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
      "$fileManager" = "kitty -e yazi";
      "$browser" = "firefox";

      # ---------
      #  General
      # ---------
      
      general = {
	      gaps_in = 5;
	      gaps_out = 10;

      	border_size = 3;

        resize_on_border = true;
      	layout = "dwindle";
      };

      # ---------
      #  Visuals
      # ---------

      decoration = {
        rounding = 6;
        active_opacity = 1.0;
	      inactive_opacity = 0.93;
	      fullscreen_opacity = 1.0;

	      shadow = {
          enabled = true;
	        range = 4;
	        render_power = 3;
	      };

	      blur = {
	        enabled = true;
	        size = 3;
	        passes = 1;
	        vibrancy = 0.1696;
	        ignore_opacity = false;
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
	      "$mod, X, exit"
        "$mod, F, fullscreen"
        "$mod, S, pseudo"
        "$mod, Space, togglefloating"

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

	      "$mod, mouse_up, workspace, e+1"
	      "$mod, mouse_down, workspace, e-1"
      ]
      ++ (
        # Workspace binds
	      builtins.concatLists (builtins.genList (i:
	        let ws = i + 1;
	        in [
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
      
      windowrule = [

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

