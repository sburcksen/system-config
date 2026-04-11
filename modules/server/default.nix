{ lib, ... }:

{
  options.server.enable = lib.mkEnableOption "server modules";

  imports = [
    ./calibre.nix
    ./jellyfin.nix
    ./radicale.nix
    ./trilium.nix
  ];
}
