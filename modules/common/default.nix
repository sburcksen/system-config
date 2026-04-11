{ lib, ... }:

{
  options.common.enable = lib.mkEnableOption "common modules";
  imports = [
    ./boot.nix
    ./locale.nix
    ./monitoringPkgs.nix
    ./nix.nix
    ./shell.nix
    ./user.nix
  ];
}
