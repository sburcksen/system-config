{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.common.syncthing;

  allDevices = {
    pc = {
      id = "E72VNQ3-MAA7PJR-27PTZCB-IZMNAWP-6J3JUC3-NGFRBHM-ISHRYPZ-N7TOMAU";
    };
    laptop = {
      id = "M7Z6SAT-NC7PYUL-FESMP35-FRI7BMO-VT7P7SX-JFRY2DC-7SVGCEG-BTDZ6A2";
    };
    nas = {
      id = "XM7OSNH-GQKUML4-2P57HSC-7THJ4B3-HGVJYUO-XCZYTY4-MVN5UMD-OLQUFAM";
    };
    phone = {
      id = "CXYF7AM-MHDEVDL-OGYXE6W-EOYQQEM-DBMJGX7-3WXVS2Z-ZLRQPR4-LHN6OQQ";
    };
  };

  allFolders = {
    notes = {
      devices = [
        "pc"
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
