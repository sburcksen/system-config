{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.desktop.theme.enable = lib.mkSubOption config.desktop.enable "theming for supported applications";

  config = lib.mkIf config.desktop.theme.enable {
    home = {
      catppuccin = {
        enable = true;
        autoEnable = true;
        flavor = "mocha";
        accent = "blue";

        cursors.enable = true;
        cursors.accent = "dark";

        # Todo
        fish.enable = true;
        starship.enable = true;

        foot.enable = true;

        mako.enable = true;

        vscodium.profiles.default = {
          enable = true;
          icons.enable = true;
          settings = {
            # Todo
            "catppuccin-icons.specificFolders" = true;
          };
        };
      };
    };
  };
}
