{ ... }:

{
  networking.hostName = "pc";

  imports = [
    ./hardware.nix
    ../../modules
  ];

  common.enable = true;
  common.kanata.enable = false;
  desktop.enable = true;
  desktop.guestSetup.enable = false;
}
