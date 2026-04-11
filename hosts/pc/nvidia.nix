{ config, pkgs, ... }:

{
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
}
