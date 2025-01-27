# core.nix

{ pkgs, inputs, lib, ... }:

# Core packages for home-manager

{
  home.packages = with pkgs; [
    # Misc
    tldr
    neo-cowsay

    # Tooling
    wget # File retrieval
    gnupg # OpenPGP
    gnumake # Make
    fd # File lookup by name, faster than finder
    (ripgrep.override { withPCRE2 = true; }) # Better grep
    # Fast code search/linter/replacer, supports most mainstream languages
    ast-grep
    sad # Search-and-replace with diff output
    just # Simple command runner
    delta # Clean git diff
    doggo # DNS client
    duf # Disk usage, new df
    du-dust # Better du
    croc # File transfer
    caddy # Webserver
    lutgen # Background themer

    # Nix tooling
    nix-index
    nix-init
    nix-melt
    nix-tree
    nix-output-monitor
  ];
  
  # Pride neofetch
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "gay-men";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
        custom_colors = [];
      };
      backend = "fastfetch";      
    };
  };
  
  # Better backend for hyfetch
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        
      ];
    };
  };

  # Fuzzy finder for everything, from files to command output
  programs.fzf.enable = true;
  # Modern resource monitor
  programs.btop.enable = true;
  
  # Git TUI
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        scrollHeight = 1;
        skipStashWarning = true;
        skipNoStagedFilesWarning = true;
        language = "en";
        nerdFontsVersion = 3;
        showBranchCommitHash = true;
        showDivergenceFromBaseBranch = "arrowAndNumber";
      };

      git = {
        parseEmoji = true; # If you actually do this i'll kill you
      };

      disableStartupPopups = true;
    };
  };
}
