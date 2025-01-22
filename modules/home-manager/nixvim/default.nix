# nixvim/default.nix

{ pkgs, inputs, lib, ... }:

# Neovim configured in the most ungodly way possible

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
  ];
  
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    nixpkgs.useGlobalPackages = true;

    performance = {
      byteCompileLua.enable = true;
      combinePlugins = {
        enable = true;
	standalonePlugins = [
	  "hmts.nvim"
	  "neorg"
	  "nvim-treesitter"
	];
      };
    };
    
    # Hijack vi/vim commands
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;

    colorschemes.tokyonight.enable = true;
    plugins.lualine.enable = true;
  };
}
