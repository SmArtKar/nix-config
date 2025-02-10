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
          settings = {
            harper-ls = {
            linters = {
              spell_check = false;
              sentence_capitalization = false;
              unclosed_quotes = true;
              wrong_quotes = false;
              long_sentences = false;
              repeated_words = false;
              matcher = false;
              avoid_curses = false;
            };
            };
          };
        };
        cssls.enable = true;
        texlab.enable = true;
        nixd.enable = true;
      };
    };
  }; 
}
