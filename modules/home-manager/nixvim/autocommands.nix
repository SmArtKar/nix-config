{
  programs.nixvim.autoCmd = [
    # Help always opens in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Enable spellcheck for purely text-based formats
    {
      event = "FileType";
      pattern = [
        "tex"
        "latex"
        "markdown"
      ];
      command = "setlocal spell spellang=en";
    }
  ];
}

