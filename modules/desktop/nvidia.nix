{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.desktop.nvidia.enable = lib.mkSubOption false "Nvidia drivers and configuration";

  config = lib.mkIf config.desktop.nvidia.enable {
    # Enable OpenGL
    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      open = true;
      nvidiaSettings = false;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };

    environment.systemPackages = [
      pkgs.egl-wayland
    ];
  };
}
