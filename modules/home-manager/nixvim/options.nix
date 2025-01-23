{
  programs.nixvim = {
    # Use system clipboard for convinience
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
      # Faster completion, a bit performance hungry, but our setup can handle it
      updatetime = 100;

      # Line numbers
      number = true; # Display absolute line number
      hidden = true; # Keep closed buffer open in the background
      mouse = "a"; # Enable mouse control
      mousemodel = "extend"; # Right click extends the extension

      # New windows are placed right and below the active one
      splitbelow = true;
      splitright = true;

      swapfile = false; # Disables the swap file
      modeline = true; # Mode tags
      modelines = 100;
      undofile = true; # Keep undo/redo history
      incsearch = true;
      inccommand = "split";
      ignorecase = true; # Both cases
      smartcase = true; # Unless we have uppercase, then match case
      cursorline = true;
      cursorcolumn = false; # Don't highlight the currently active column
      fileencoding = "utf-8"; # Default file encoding
      termguicolors = true; # 24-bit colors
      spell = false; # Disable spelling highlights
      wrap = false; # Don't wrap text either, hell to work with

      tabstop = 2; # What is our spaces to tabs exchange rate, sire?
      shiftwidth = 2; # Number of spaces used for each step of autoindentation
      expandtab = true; # Converts tab to spaces in insert mode
      autoindent = true; # Clever indenting
    };
  };
}
