{ lib, ... }:

with lib;
{
  options.desktop.enable = mkEnableOption "desktop options";

  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./development.nix
    ./hyprland.nix
    ./login.nix
    ./wifi.nix
  ];
}
