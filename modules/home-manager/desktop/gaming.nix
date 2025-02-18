# gaming.nix

{ pkgs, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    lutris
    protonup-ng
  ];

  services.xembed-sni-proxy.enable = true;
}
