{ config, ... }:

{
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      options.globalstatus = true;

      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [ "filename" "diff" ];
        lualine_x = [
          "diagnostics"

          # Show active language server
          {
            __unkeyed.__raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_active_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
            icon = "";
            color.fg = config.lib.stylix.colors.withHashtag.base07;
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
        lualine_y = [
          {
            __unkeyed.__raw = ''
              function()
                  local starts = vim.fn.line("v")
                  local ends = vim.fn.line(".")
                  local count = starts <= ends and ends - starts + 1 or starts - ends + 1
                  local wc = vim.fn.wordcount()
                  return count .. ":" .. wc["visual_chars"]
              end
            '';

            cond.__raw = ''
              function()
                  return vim.fn.mode():find("[Vv]") ~= nil
              end
            '';

            color.fg = config.lib.stylix.colors.withHashtag.base07;
          }
        ];
      };
    };
  };
}
