{ config, lib, ... }:

{
  options.server.radicale.enable = lib.mkSubOption config.server.enable "audio interface";

  config = lib.mkIf config.server.radicale.enable {
    services.radicale = {
      enable = true;
      settings = {
        server.hosts = [ "0.0.0.0:5232" ];
        storage.filesystem_folder = "/data_ssd/radicale/collections";
        auth = {
          type = "htpasswd";
          htpasswd_filename = "/data_ssd/radicale/users";
          htpasswd_encryption = "bcrypt";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [
      5232
    ];
  };
}
