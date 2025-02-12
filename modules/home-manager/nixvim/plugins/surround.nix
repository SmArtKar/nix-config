# surround.nix

{ pkgs, inputs, lib, ... }:

{
  programs.nixvim.plugins.vim-surround = {
    enable = true;
  };
}
