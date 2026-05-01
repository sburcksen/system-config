{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.common.syncthing;

  allDevices = {
    desktop = {
      id = "";
    };
    laptop = {
      id = "";
    };
    nas = {
      id = "";
    };
    phone = {
      id = "";
    };
  };

  allFolders = {
    notes = {
      devices = [
        "desktop"
        "laptop"
        "nas"
        "phone"
      ];
    };
  };

  hostname = config.networking.hostName;
  deviceFolders = lib.filterAttrs (_: f: builtins.elem hostname f.devices) allFolders;
in
{
  options.common.syncthing = {

    enable = lib.mkSubOption config.common.enable "Syncthing";

    gui = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    baseDir = lib.mkOption {
      type = lib.types.str;
      default = "/home/sburcksen/Documents";
    };
  };

  config = lib.mkIf cfg.enable {

    services.syncthing = {
      enable = true;
      user = "sburcksen";
      group = "users";
      configDir = "/home/sburcksen/.config/syncthing";
      openDefaultPorts = true;

      settings = {
        overrideDevices = true;
        overrideFolders = true;
        devices = allDevices;
        folders = lib.mapAttrs (name: f: {
          inherit (f) devices;
          path = "${cfg.baseDir}/${name}";
        }) deviceFolders;

        guiAddress = lib.mkIf cfg.gui "0.0.0.0:8384";
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.gui [ 8384 ];
  };
}
