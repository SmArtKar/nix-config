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
  };
}
