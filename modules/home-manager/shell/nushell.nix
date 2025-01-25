# nushell.nix

{ pkgs, inputs, lib, ... }:

# Nushell shell

let
  shellAliases = {
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    vi = "hx";
    vim = "hx";
    nano = "hx";
  };
in {
  # Does not work in nushell, needs to be manually assigned down the line
  home.shellAliases = shellAliases;

  programs.nushell = {
    enable = true;
    configFile.source = ./nushell/config.nu;
    inherit shellAliases;
  };
  
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.carapace = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
}
