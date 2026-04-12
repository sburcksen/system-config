{ lib, ... }:

{
  options.desktop.enable = lib.mkEnableOption "desktop modules";

  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./devPkgs.nix
    ./guestSetup.nix
    ./hyprland.nix
    ./kanata.nix
    ./login.nix
    ./networking.nix
    ./nvidia.nix
  ];
}
