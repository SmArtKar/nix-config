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

      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " File";
      display-ssh = " SSH";
      
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
        bg = mkLiteral "${colors.base00}";
        bg-alt = mkLiteral "${colors.base0E}";
        foreground = mkLiteral "${colors.base02}";
        selected = mkLiteral "${colors.base0F}";
        active = mkLiteral "${colors.base0D}";
        text-selected = mkLiteral "${colors.base00}";
        text-color = mkLiteral "${colors.base07}";
        border-color = mkLiteral "${colors.base0E}";
        urgent = mkLiteral "${colors.base08}";
        font = "JetBrainsMono Nerd Font Mono 12";
      };
      "window" = {
        width = mkLiteral "50%";
        transparency = "real";
        orientation = mkLiteral "vertical";
        cursor = mkLiteral "default";
        spacing = mkLiteral "0px";
        border = mkLiteral "2px";
        border-color = "@border-color";
        border-radius = mkLiteral "16px";
        background-color = mkLiteral "@bg";
      };
      "mainbox" = {
        padding = mkLiteral "15px";
        enabled = true;
        orientation = mkLiteral "vertical";
        children = map mkLiteral [
          "inputbar"
          "listbox"
        ];
        background-color = mkLiteral "transparent";
      };
      "inputbar" = {
        enabled = true;
        padding = mkLiteral "10px 10px 200px 10px";
        margin = mkLiteral "10px";
        background-color = mkLiteral "@urgent";
        border-radius = "16px 16px 0px 0px";
        orientation = mkLiteral "horizontal";
        children = map mkLiteral [
          "entry"
          "dummy"
          "mode-switcher"
        ];
      };
      "entry" = {
        enabled = true;
        expand = false;
        width = mkLiteral "20%";
        padding = mkLiteral "10px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@text-selected";
        cursor = mkLiteral "text";
        placeholder = " 󰨇 Search ";
        placeholder-color = mkLiteral "inherit";
      };
      "listbox" = {
        spacing = mkLiteral "10px";
        padding = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = map mkLiteral [
          "message"
          "listview"
        ];
      };
      "listview" = {
        enabled = true;
        columns = 2;
        lines = 6;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = false;
        fixed-columns = true;
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        border = mkLiteral "0px";
      };
      "dummy" = {
        expand = true;
        background-color = mkLiteral "transparent";
      };
      "mode-switcher" = {
        enabled = true;
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
      };
      "button" = {
        width = mkLiteral "5%";
        padding = mkLiteral "12px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@text-selected";
        text-color = mkLiteral "@text-color";
        cursor = mkLiteral "pointer";
      };
      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@text-selected";
      };
      "scrollbar" = {
        width = mkLiteral "4px";
        border = 0;
        handle-color = mkLiteral "@border-color";
        handle-width = mkLiteral "8px";
        padding = 0;
      };
      "element" = {
        enabled = true;
        spacing = mkLiteral "10px";
        padding = mkLiteral "10px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "transparent";
        cursor = mkLiteral "pointer";
      };
      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element normal.active" = {
        background-color = mkLiteral "@active";
        text-color = mkLiteral "@foreground";
      };
      "element selected.normal" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@text-selected";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@text-selected";
      };
      "element selected.active" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@text-selected";
      };
      "element alternate.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
      "element alternate.urgent" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
      "element alternate.active" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "36px";
        cursor = mkLiteral "inherit";
      };
      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "message" = {
        background-color = mkLiteral "transparent";
        border = mkLiteral "0px";
      };
      "textbox" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@bg";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "error-message" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@bg";
      };
    };
  };
}

