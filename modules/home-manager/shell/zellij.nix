# zellij.nix

{ pkgs, inputs, lib, ... }:

# Zellij terminal multiplexer aka better tmux

{
  programs.zellij = {
    enable = true;
    settings = {
      copy_command = "wl-copy";
      copy_on_select = false;
      default_layout = "compact";

      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
      
      plugins = {
        tab-bar = {
          path = "tab-bar";
        };
        status-bar = {
          path = "status-bar";
        };
        strider = {
          path = "strider";
        };
        compact-bar = {
          path = "compact-bar";
        };
      };
    };
  };
}
