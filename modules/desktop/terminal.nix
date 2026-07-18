{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.desktop.terminal.enable = lib.mkSubOption config.desktop.enable "terminal";
  config = lib.mkIf config.desktop.terminal.enable {
    home = {
      programs.foot = {
        enable = true;

        settings = {
          main = {
            font = "JetBrainsMonoNerdFont-Regular:size=12";
            pad = "3x0";
          };
          #colors-dark.alpha = 0.8;
        };
      };
    };
  };
}
