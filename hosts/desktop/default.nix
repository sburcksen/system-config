{ ... }:

{
  networking.hostName = "Desktop-Nix-SB";

  imports = [
    ./hardware.nix
    #./nvidia.nix
    ../../modules
  ];

  desktop.enable = true;
}
