{ config, lib, ... }:

{
  options.desktop.bluetooth.enable = lib.mkSubOption config.desktop.enable "Bluetooth";

  config = lib.mkIf config.desktop.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
