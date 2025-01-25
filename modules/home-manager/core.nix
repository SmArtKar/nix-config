# core.nix

{ pkgs, inputs, lib, ... }:

# Core packages for home-manager

{
  home.packages = with pkgs; [
    # Misc
    fastfetch
    tldr
    neo-cowsay

    # Tooling
    wget # File retrieval
    gnupg # OpenPGP
    gnumake # Make
    fzf # Fuzzy finder for everything, from files to command output
    fd # File lookup by name, faster than finder
    (ripgrep.override { withPCRE2 = true; }) # Better grep
    # Fast code search/linter/replacer, supports most mainstream languages
    ast-grep
    sad # Search-and-replace with diff output
    just # Simple command runner
    delta # Clean git diff
    lazygit # Git UI
    doggo # DNS client
    duf # Disk usage, new df
    du-dust # Better du
    croc # File transfer
    caddy # Webserver
    lutgen # Background themer
    btop # Resource monitor

    # Nix tooling
    nix-index
    nix-init
    nix-melt
    nix-tree
    nix-output-monitor
  ];
}
