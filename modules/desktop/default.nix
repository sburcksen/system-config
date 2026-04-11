{ lib, ... }:

{
  options.desktop.enable = lib.mkEnableOption "desktop options";

  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./devPkgs.nix
    ./hyprland.nix
    ./login.nix
    ./networking.nix
  ];
}
