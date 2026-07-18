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

        gtk.icon.enable = true;

        firefox.enable = true;
        firefox.force = true;
        firefox.accent = "pink";

        foot.enable = true;

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
