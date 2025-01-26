# telegram.nix

{ pkgs, inputs, lib, ... }:

# Telegram client, of dealer's choice

{
  home.packages = with pkgs; [
    telegram-desktop
  ];
}
