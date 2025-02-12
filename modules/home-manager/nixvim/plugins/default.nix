{ pkgs, inputs, lib, config, ... }:

# Nixvim plugins

{
  imports = [
    ./barbar.nix
    ./lualine.nix
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix
    ./neorg.nix
    ./neotree.nix
    ./starify.nix
    ./surround.nix
  ];

  programs.nixvim = {
    colorschemes.tokyonight.enable = true;

    plugins = {
      # Lazyloading plugins
      lz-n.enable = true;

      web-devicons.enable = true;

      gitsigns.enable = true;

      nvim-autopairs.enable = true;

      colorizer = {
        enable = true;
        settings = {
          mode = "foreground";
          user_default_options.names = false;
        };
      };

      oil = {
        enable = true;
        lazyLoad.settings.cmd = "Oil";
      };

      comment = {
        enable = true;
        settings = {
          opleader.line = "<C-b>";
          toggler.line = "<C-b>";
        };
      };

      indent-blankline.enable = true;

      floaterm = {
        enable = true;
        settings = {
          width = 0.8;
          height = 0.8;
          title = "";
          borderchars = "─│─│╭╮╯╰";
          keymap_toggle = "<C-`>";
        };
      };
    };
  };
}
