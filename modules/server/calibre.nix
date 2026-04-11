{ config, lib, ... }:

{
  options.server.calibre.enable = lib.mkSubOption config.server.enable "Calibre Web";

  config = lib.mkIf config.server.calibre.enable {
    services.calibre-web = {
      enable = true;
      listen.ip = "0.0.0.0";
      listen.port = 8083;
      openFirewall = true;
      options = {
        calibreLibrary = "/data_ssd/calibre/library";
        enableBookUploading = true;
        enableBookConversion = true;
      };
    };
  };
}
