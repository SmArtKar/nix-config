# zellij.nix

{ pkgs, inputs, lib, ... }:

# Zellij terminal multiplexer aka better tmux

{
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/config.kdl".source = ./../../../configs/zellij/config.kdl;
}
