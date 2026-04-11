{ config, lib, ... }:

{
  options.desktop.networking.enable = lib.mkSubOption config.desktop.enable "networking configuration";

  config = lib.mkIf config.desktop.networking.enable {
    # Enable networking via IWD
    networking.wireless.iwd.enable = true;
    networking.wireless.iwd.settings = {
      IPv6 = {
        Enabled = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };

    networking.networkmanager.enable = false;
  };
}
