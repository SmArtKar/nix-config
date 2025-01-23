{
  programs.nixvim.plugins = {
    lsp-format = {
      enable = true;
      lspServersToEnable = "all";
    };

    lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        silent = true;
        # Diagnostics navigation
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };

        lspBuf = {
          gd = "definition";
          gD = "references";
          gt = "type_definition";
          gi = "implementation";
          K = "hover";
          "<F2>" = "rename";
        };
      };

      servers = {
        harper_ls = {
          enable = true;
          extraOptions = {
            spell_check = false;
            avoid_curses = false; # we reclaim slurs in this house
            sentence_capitalization = false;
            long_sentences = false;
            repeated_words = false;
            matcher = false;
          };
        };
        cssls.enable = true;
        texlab.enable = true;
      };
    };
  }; 
}
