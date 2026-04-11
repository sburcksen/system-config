{ config, lib, ... }:

{
  options.desktop.login.enable = lib.mkSubOption config.desktop.enable "login manager";

  config = lib.mkIf config.desktop.login.enable {
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
    };
  };
}
