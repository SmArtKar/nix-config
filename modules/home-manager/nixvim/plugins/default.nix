{ pkgs, inputs, lib, config, ... }:

# Nixvim plugins

{
  imports = [
    ./lualine.nix
    #./telescope.nix
    #./treesitter.nix
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
        settings.user_default_options.names = false;
      };

      oil = {
        enable = true;
        lazyLoad.settings.cmd = "Oil";
      };

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "neo-tree"
            "TelescopePrompt"
          ];
        };
      };
    };
  };
}
