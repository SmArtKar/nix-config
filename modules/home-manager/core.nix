# core.nix

{ pkgs, inputs, lib, ... }:

# Core packages for home-manager

{
  imports = [
    ./shell/git.nix
    ./shell/yazi.nix
  ];

  home.packages = with pkgs; [
    # Misc
    tldr
    neo-cowsay
    thefuck

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
    yq # YAML/TOML processing

    # Nix tooling
    nix-index
    nix-init
    nix-melt
    nix-tree
    nix-output-monitor

    # Lang packages
    stdenv
    python311
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
      display = {
        separator = " ";
      };

      modules = [
        "break"
	      "break"
	      {
          "type" = "title";
          "keyWidth" = 10;
        }
        "break"
        {
          "type" = "os";
          "key" = " ";
          "keyColor" = "34";
        }
        {
          "type" = "kernel";
          "key" = " ";
          "keyColor" = "34";
        }
        {
          "type" = "terminal";
          "key" = " ";
          "keyColor" = "34"; 
        }
        {
          "type" = "shell";
          "key" = " ";
          "keyColor" = "34"; 
        }
        {
          "type" = "terminalfont";
          "key" = " ";
          "keyColor" = "34";
        }
        "break"
        {
          "type" = "wm";
          "key" = " ";
          "keyColor" = "34";
        }
        {
          "type" = "uptime";
          "key" = " ";
          "keyColor" = "34"; 
        }
        {
          "type" = "command";
          "key" = "󱦟 ";
          "keyColor" = "34";
          "text" = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          "type" = "datetime";
          "format" = "{1}-{3}-{11}";
          "key" = " ";
          "keyColor" = "34";
        }
        {
          "type" = "media";
          "key" = "󰝚 ";
          "keyColor" = "34";
        }
        "break"
        {
          "type" = "cpu";
          "key" = " ";
          "keyColor" = "blue";
        }
        {
          "type" = "gpu";
          "key" = " ";
          "keyColor" = "blue";
        }
        {
          "type" = "memory";
          "key" = " ";
          "keyColor" = "blue";
        }
        {
          type = "disk";
          key = "󱛟 ";
          keyColor = "blue";
        }
        "break"
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
