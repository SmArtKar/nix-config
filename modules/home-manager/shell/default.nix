# shell

{ pkgs, inputs, lib, ... }:

# Core shell config

{
  imports = [
    ./nushell.nix
    ./starship.nix
  ];

  # A better cd command with global memory
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration= true;
    options = [
      "--cmd cd"
    ];
  };

  # Atuin history manager
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      search_mode = "fuzzy";
      keymap_mode = "vim-normal";
    };
    flags = [
      "--disable-up-arrow"
    ];
  };
}
