{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.common.monitoringPkgs.enable = lib.mkSubOption config.common.enable "system monitoring packages";

  config = lib.mkIf config.common.monitoringPkgs.enable {
    environment.systemPackages = with pkgs; [
      htop
      smartmontools
      hdparm
      iperf3
    ];
  };
}
