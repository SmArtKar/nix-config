# stylix.nix

{ pkgs, inputs, lib, ... }:

# home-manager version of stylix file - only configures some targets for stylix

{
  stylix.targets = {
    neovim.enable = true;
  };
}
