# thunar.nix
{ pkgs, inputs, lib, ... }:

# Thunar file manager

{
  home.packages = with pkgs; [
    xfce.thunar
  ];
}
