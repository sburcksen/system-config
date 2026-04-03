{ modules, ... }:

{
  networking.hostName = "Desktop-Nix-SB";

  imports = with modules; [
    ./hardware.nix
    #./nvidia.nix
    common.default
    desktop.default
  ];
}
