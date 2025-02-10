# vscode.nix

{ pkgs, inputs, lib, ... }:

# VSCode text editor

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}
