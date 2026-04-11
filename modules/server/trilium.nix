{ config, lib, ... }:

{
  options.server.trilium.enable = lib.mkSubOption config.server.enable "Trilium";

  config = lib.mkIf config.server.trilium.enable {
    services.trilium-server = {
      enable = true;
      dataDir = "/data_ssd/trilium";
      host = "0.0.0.0";
      port = 8080;
    };

    networking.firewall.allowedTCPPorts = [
      8080
    ];
  };
}
