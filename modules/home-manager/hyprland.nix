# hyprland.nix

{ pkgs, inputs, lib, ... }:

# Hyprland WM - requires kitty.nix to function

{
  imports = 
  [
    ./kitty.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "hyprctl setcursor Vimix 24"
      ];

      # --------
      #  Inputs
      # --------

      input = {
	follow_mouse = true;
	mouse_refocus = false;
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
      "$menu" = "rofi -show combi";
      "$fileManager" = "kitty -e yazi";
      "$internetBrowser" = "firefox";

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
	   color = "rgba(00000099)";
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
	"$mod, B, exec, $internetBrowser"
	"$mod, E, exec, $fileManager"
	"$mod, C, killactive"
	"$mod, M, exit"

        # Focus movement
	"$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"

        # Workspace scrolling

	"$mod, mouse_down, workspace, e+1"
	"$mod, mouse_up, workspace, e-1"
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
    };
  };

  home.sessionVariables = {
    # Fixes cursor issues
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hints electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
}

