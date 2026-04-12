{ ... }:

{
  networking.hostName = "pc";

  imports = [
    ./hardware.nix
    ../../modules
  ];

  common.enable = true;
  desktop = {
    enable = true;
    guestSetup.enable = false;
    kanata.enable = false;
  };

  system.stateVersion = "24.11";
}
