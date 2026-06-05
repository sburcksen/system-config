{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.common.nvim.enable = lib.mkSubOption config.common.enable "Neovim install and configuation";

  config = lib.mkIf config.common.nvim.enable {
    home = {
      programs.nvf = {
        enable = true;

        settings.vim = {
          viAlias = true;
          vimAlias = true;

          options = {
            number = true;
            relativenumber = true;
            shiftwidth = 2;
            tabstop = 2;
          };

          spellcheck = {
            enable = true;
            programmingWordlist.enable = true;
          };

          lsp = {
            enable = true;

            formatOnSave = true;
            lspkind.enable = false;
            lightbulb.enable = true;
            lspsaga.enable = false;
            trouble.enable = true;
          };

          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;

            nix.enable = true;
            markdown.enable = true;
            lua.enable = true;
            bash.enable = true;
            clang.enable = true;
            cmake.enable = true;
            json.enable = true;
            sql.enable = true;
            python.enable = true;
            rust = {
              enable = true;
              extensions.crates-nvim.enable = false;
            };
            docker.enable = true;
          };

          visuals = {
            nvim-cursorline.enable = true;
            highlight-undo.enable = true;
          };

          statusline.lualine = {
            enable = true;
            theme = "catppuccin";
          };

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
            transparent = false;
          };

          autopairs.nvim-autopairs.enable = true;

          autocomplete.nvim-cmp.enable = true;
          autocomplete.blink-cmp.enable = false;

          snippets.luasnip.enable = true;

          treesitter.context.enable = true;

          telescope.enable = true;

        };
      };
    };
  };
}
