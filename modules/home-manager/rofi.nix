# rofi.nix

{ pkgs, inputs, config, lib, ... }:

# Rofi Application Launcher

let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    # Ugly as sin, but home does not support rofi-wayland so we need to redirect it manually
    /*
    package = pkgs.rofi-wayland.overrideAttrs (_: rec {
      version = "1.7.8+wayland1";
      src = pkgs.fetchFromGitHub {
        owner = "lbonn";
        repo = "rofi";
        rev = version;
        sha256 = "sha256-fNRq4Iepuhcs0ADrMTyEsqr/wVHjFgjb2CAjYVxUWwo=";
      };
    });
    */

    package = pkgs.rofi-wayland;
    
    location = "center";

    extraConfig = {
      modi = "combi";
      combi-modi = "drun, run, filebrowser, ssh";
      terminal = "kitty";
      case-sensitive = false;
      cycle = true;
      show-icons = true;
      display-combi = "";
      display-drun = "";
      monitor = "primary";
      steal-focus = true;
      
      # Matching setting
      matching = "fuzzy";
      tokenize = true;

      # SSH settings
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;

      # Drun settings
      drun-categories = "";
      drun-match-fields = "name, generic, exec, categories, keywords";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      drun-show-actions = false;
      drun-url-launcher = "xdg-open";
      drun-use-desktop-cache = false;
      drun-reload-desktop-cache = false;

      # Run settings
      run-command = "{cmd}";
      run-list-command = "";
      run-shell--command = "{terminal} -e {cmd}";
      run-display-format = "{name}";
    };
    
    /*
    theme = {
      "*" = {
        font = "Iosevka Nerd Font";
	g-spacing = mkLiteral "10px";
	g-margin = mkLiteral "0px";
	b-color = mkLiteral "#000000FF";
	fg-color = mkLiteral "#FFFFFFFF";
	fgp-color = mkLiteral "#888888FF";
	b-radius = mkLiteral "8px";
	g-padding = mkLiteral "8px";
	hl-color = mkLiteral "#FFFFFFFF";
	hlt-color = mkLiteral "#000000FF";
	alt-color = mkLiteral "#111111FF";
	wbg-color = mkLiteral "#000000CC";
	w-border = mkLiteral "2px solid";
	w-border-color = mkLiteral "#FFFFFFFF";
	w-padding = mkLiteral "12px";
        transparency = "real";
      };

      window = {
	width = mkLiteral "450px";
	border-radius = mkLiteral "@b-radius";
	background-color = mkLiteral "@wbg-color";
	border = mkLiteral "@w-border";
	border-color = mkLiteral "@w-border-color";
	padding = mkLiteral "@w-padding";
      };
      
      listview = {
        columns = 1;
	lines = 7;
	fixed-height = true;
	fixed-columns = true;
	cycle = false;
	scrollbar = false;
	border = mkLiteral "0px solid";
      };

      /*

      prompt = {
        text-color = mkLiteral "@fg-color";
      };

      inputbar = {
        children = mkLiteral "[\"prompt\", \"entry\"]";
	spacing = mkLiteral "@g-spacing";
      };

      entry = {
        placeholder = "Search";
	text-color = mkLiteral "@fg-color";
	placeholder-color = mkLiteral "@fgp-color";
      };

      mainbox = {
        spacing = mkLiteral "@g-spacing";
	margin = mkLiteral "@g-margin";
	padding = mkLiteral "@g-padding";
	children = mkLiteral "[\"inputbar\", \"listview\", \"message\"]";
      };

      element = {
        spacing = mkLiteral "@g-spacing";
	margin = mkLiteral "@g-margin";
	padding = mkLiteral "@g-padding";
	border = mkLiteral "0px solid";
	border-radius = mkLiteral "@b-radius";
	border-color = mkLiteral "@b-color";
	background-color = mkLiteral "transparent";
	text-color = mkLiteral "@fg-color";
      };

      "element normal.normal" = {
        background-color = mkLiteral "transparent";
	text-color = mkLiteral "@fg-color";
      };

      "element alternate.normal" = {
        background-color = mkLiteral "@alt-color";
	text-color = mkLiteral "@fg-color";
      };

      "element selected.active" = {
        background-color = mkLiteral "@hl-color";
	text-color = mkLiteral "@hlt-color";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@hl-color";
	text-color = mkLiteral "@hlt-color";
      };

      message = {
        background-color = mkLiteral "red";
	border = mkLiteral "0px solid";
      };
      */
    # };
  };
}
