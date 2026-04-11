{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.desktop.guestSetup.enable = lib.mkSubOption config.desktop.enable "guest setup";

  config = lib.mkIf config.desktop.guestSetup.enable {
    services.desktopManager.plasma6.enable = true;

    users.users.guest = {
      isNormalUser = true;
      description = "Guest";
      packages = [
        pkgs.firefox
      ];
    };
  };
}
