# starship.nix

{ pkgs, inputs, config, lib, ... }:

# Starship prompt
let
  # Colors used in the markup
  colors = config.lib.stylix.colors.withHashtag;
in 
{ 
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableNushellIntegration = true;

    settings = {
      add_newline = false;
      
      format = lib.concatStrings [
        "[](color_purple)"
        "$os"
        "$username"
        "[](fg:color_purple bg:color_blue)"
        "$directory"
        "[](fg:color_blue bg:color_green)"
        "$git_branch"
        "$git_status"
        "[](fg:color_green bg:color_bg3)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "$lua"
        "$zig"
        "[](fg:color_bg3 bg:color_bg2)"
        "$docker_context"
        "$conda"
        "$nix_shell"
        "[](fg:color_bg2 bg:color_bg1)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break$character"
      ];

      palette = "smartkar-stylized";
      palettes.smartkar-stylized = {
        color_text = colors.base06;
        color_bg1 = colors.base01;
        color_bg2 = colors.base02;
        color_bg3 = colors.base03;
        color_blue = "#4c72c4"; #colors.base0D;
        color_aqua = colors.base0C;
        color_green = "#75ad39"; #colors.base0B;
        color_orange = colors.base09;
        color_purple = "#8766c4"; #colors.base0E;
        color_red = colors.base08;
        color_yellow = colors.base10;
      };

      username = {
        show_always = true;
        style_user = "bg:color_purple fg:color_text";
        style_root = "bg:color_purple fg:color_text";
        format = "[ $user ]($style)";
        disabled = false;
      };

      os = {
        disabled = false;
        style = "bg:color_purple fg:color_text";
      };
        
      directory = {
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        style = "bg:color_blue fg:color_text";
      };

      git_branch = {
        style = "bg:color_green";
        format = "[[ $symbol $branch ](fg:color_text bg:color_green)]($style)";
      };
      
      git_status = {
        style = "bg:color_green";
        format = "[[($all_status$ahead_behind )](fg:color_text bg:color_green)]($style)";
      };
      
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_text bg:color_bg1)]($style)";
      };

      docker_context = {
        style = "bg:color_bg2";
        format = "[[ $symbol( $context ) ](bg:color_bg2 fg:color_text)]($style)";
      };

      conda = {
        style = "bg:color_bg2";
        format = "[[ $symbol( $environment ) ](bg:color_bg2 fg:color_text)]($style)";
      };

      nix_shell = {
        style = "bg:color_bg2";
        format = "[[ $symbol( $name ) ](bg:color_bg2 fg:color_text)]($style)";
      };

      c = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      rust = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      golang = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      nodejs = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      php = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      java = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      kotlin = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      haskell = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      python = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      lua = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      zig = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version ) ](bg:color_bg3 fg:color_text)]($style)";
      };

      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vimcmd_symbol = "[](bold green)";
        vimcmd_replace_one_symbol = "[](bold purple)";
        vimcmd_replace_symbol = "[](bold purple)";
        vimcmd_visual_symbol = "[](bold yellow)";
      };

      # Converts starship to use Nerd Font symbols
      aws.symbol = "🅰 ";
      buf.symbol = " ";
      c.symbol = " ";
      cmake.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      directory = {
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = "󰇚 ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
        };
        read_only = " 󰌾";
      };
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";
      git_branch.symbol = " ";
      git_commit.tag_symbol = "  ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CachyOS = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Kali = " ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        Nobara = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        RockyLinux = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Void = " ";
        Windows = "󰍲 ";
      };
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = "󱘗 ";
      scala.symbol = " ";
      swift.symbol = " ";
      zig.symbol = " ";
      gradle.symbol = " ";
    };
  };
}
