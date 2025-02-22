# rofi.nix

{ pkgs, inputs, config, lib, ... }:

# Rofi Application Launcher

let
  inherit (config.lib.formats.rasi) mkLiteral;
  # Colors used in the markup
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    
    location = "center";

    extraConfig = {
      modi = "drun,filebrowser,run";
      terminal = "kitty";
      case-sensitive = false;
      cycle = true;
      show-icons = true;
      monitor = "primary";
      steal-focus = true;
      sidebarMode = false;
      hover-select = true;

      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " File";
      display-ssh = " SSH";
      
      # Matching setting
      # matching = "fuzzy";
      tokenize = true;

      # SSH settings
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;

      # Drun settings
      drun-categories = "";
      drun-match-fields = "name, generic, exec, categories, keywords";
      drun-display-format = "{icon} {name}";
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

    theme = lib.mkForce {
      "*" = {
        bg = mkLiteral "${colors.base00}AF";
        bg-alt = mkLiteral "${colors.base06}E6";
        bg-entry = mkLiteral "${colors.base00}AF";
        # bg-entry = mkLiteral "${colors.base06}E6";
        text = mkLiteral "${colors.base06}E6";
        text-alt = mkLiteral "${colors.base01}E6";
        text-entry = mkLiteral "${colors.base06}E6";
        # text-entry = mkLiteral "${colors.base01}E6";
        text-placeholder = mkLiteral "${colors.base04}E6";
        # text-placeholder = mkLiteral "${colors.base03}E6";
        font = "${config.visual.rofiFont} 12";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@text";
      };

      window = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = mkLiteral "false";
        
        orientation = mkLiteral "vertical";
        cursor = "default";
        
        border-radius = mkLiteral "8px";
        enabled = mkLiteral "true";
        width = mkLiteral "640px";
        background-color = mkLiteral "transparent";
      };

      mainbox = {
        enabled = mkLiteral "true";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = map mkLiteral [ "inputbar" "listbox" ];
      };

      listbox = {
        orientation = mkLiteral "vertical";
        children = map mkLiteral [ "listview" ];
        background-color = mkLiteral "@bg";
      };
      
      inputbar = {
        text-color = mkLiteral "@text-entry";
        background-color = mkLiteral "@bg-entry";
        font = "${config.visual.rofiFont} 18";
        padding = mkLiteral "12px 12px 16px 12px";
        spacing = mkLiteral "12px";
        children = map mkLiteral [ "icon-search" "entry" ];
      };

      icon-search = {
        expand = mkLiteral "false";
        filename = "search";
        size = mkLiteral "28px";
        color = mkLiteral "@text-placeholder";
      };

      element-icon = {
        cursor = mkLiteral "pointer";
        vertical-align = mkLiteral "0.5";
      };

      element-text = {
        cursor = mkLiteral "pointer";
        vertical-align = mkLiteral "0.5";
      };

      scrollbar = {
        cursor = mkLiteral "pointer";
        vertical-align = mkLiteral "0.5";
      };

      entry = {
        vertical-align = mkLiteral "0.5";
        font = mkLiteral "inherit";
        placeholder = "Search";
        placeholder-color = mkLiteral "@text-placeholder";
      };

      textbox = {
        padding = mkLiteral "8px 24px";
      };

      message = {
        background-color = mkLiteral "@bg";
      };

      listview = {
        lines = mkLiteral "10";
        columns = mkLiteral "1";
        fixed-height = false;
      };

      element = {
        padding = mkLiteral "8px 8px";
        spacing = mkLiteral "16px";
        background-color = mkLiteral "transparent";
      };

      "element normal active" = {
        text-color = mkLiteral "@text";
      };

      "element alternate active" = {
        text-color = mkLiteral "@text";
      };

      "element selected normal" = {
        text-color = mkLiteral "@text-alt";
        background-color = mkLiteral "@bg-alt";
      };

      "element selected active" = {
        text-color = mkLiteral "@text-alt";
        background-color = mkLiteral "@bg-alt";
      };

      element-icon = {
        size = mkLiteral "1.5em";  
      };

      element-text = {
        text-color = mkLiteral "inherit";
      };
    };
  };
}

