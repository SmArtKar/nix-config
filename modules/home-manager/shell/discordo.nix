# discordo.nix

{ pkgs, inputs, lib, ... }:

# Discord CLI client

{
  home.packages = with pkgs; [
    discordo
  ];
}
