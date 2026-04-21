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
      home = {
        packages = with pkgs; [
          lua-language-server
          nixd
          nixfmt
          clang-tools
          rust-analyzer
        ];
        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      };

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        withRuby = false;
        withPython3 = false;
      };

      xdg.configFile = {
        "nvim".source = ../../../dotfiles/nvim;
      };
    };
  };
}
