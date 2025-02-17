# gaming.nix

{ pkgs, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    lutris
    protonup-ng
  ];
}
