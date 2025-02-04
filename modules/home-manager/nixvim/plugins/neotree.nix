{  
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = ":Neotree action=focus reveal toggle <CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>f";
        action = ":Neotree action=focus <CR>";
        options.silent = true;
      }
    ];

    plugins.neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      popupBorderStyle = "rounded";
      window = {
        width = 30;
        autoExpandWidth = true;
      };
      extraOptions = {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false;
          };
        };
      };
    };
  };
}
