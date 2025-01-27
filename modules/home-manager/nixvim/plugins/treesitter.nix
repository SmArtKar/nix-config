{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };

      folding = false;
    };

    treesitter-refactor = {
      enable = true;
        highlightDefinitions = {
        enable = true;
        clearOnCursorMove = false; # We update too frequently
        };
      };

    hmts.enable = true;
    };
}
