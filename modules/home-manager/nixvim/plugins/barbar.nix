{
  programs.nixvim.plugins.barbar = {
    enable = true;
    keymaps = {
      next.key = "<TAB>";
      previous.key = "<C-TAB>";
      close.key = "<C-w>";
    };
  };
}
