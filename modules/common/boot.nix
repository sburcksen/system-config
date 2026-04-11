{ config, lib, ... }:

{
  options.common.boot.enable = lib.mkSubOption config.common.enable "boot configuration";

  config = lib.mkIf config.common.boot.enable {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      kernelParams = [
        # Fix for screen flickering on Wayland
        "amdgpu.dcdebugmask=0x10"
        # Silent boot
        "quiet"
        "splash"
        "vga=current"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "loglevel=3"
      ];
      # Silent boot
      plymouth.enable = true;
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
  };
}
