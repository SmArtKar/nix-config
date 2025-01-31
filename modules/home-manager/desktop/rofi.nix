# rofi.nix

{ pkgs, inputs, config, lib, ... }:

# Rofi Application Launcher

let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
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
    
    theme = lib.mkForce {
      "*" = {
        font = "Montserrat 12";
        bg0 = "#242424E6";
        bg1 = "#7E7E7E80";
        bg2 = "#0860f2E6";

        fg0 = "#DEDEDE";
        fg1 = "#FFFFFF";
        fg2 = "#DEDEDE80";

        background-color = "transparent";
        text-color = "#DEDEDE";
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      window = {
        background-color = "#242424E6";
        location = "center";
        width = 640;
        border-radius = 6;
      };

      inputbar = {
        font = "Montserrat 20";
        padding = "12px";
        spacing = "12px";
        children = [
          "icon-search"
          "entry"
        ];
      };
 
      icon-search = {
        expand = false;
        filename = "search";
        size = "28px";
      };

      entry = {
        font = "inherit";
        placeholder = "Search";
        placeholder-color = "#DEDEDE80";
      };
    };
  };
}
