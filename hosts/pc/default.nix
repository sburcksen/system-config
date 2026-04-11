{ ... }:

{
  networking.hostName = "pc";

  imports = [
    ./hardware.nix
    ../../modules
  ];

  common.enable = true;
  desktop.enable = true;
}
