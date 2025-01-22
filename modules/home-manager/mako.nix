# mako.nix

{ pkgs, inputs, lib, ... }:

# Mako notification daemon

{
  services.mako = {
    enable = true;
    sort = "-time";

    extraConfig = "
      max-history = 100;
    ";
  };
}
