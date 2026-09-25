{ ... }: {
  networking.hostName = "pc";

  imports = [
    ./hardware.nix
    ../../modules
  ];

  common.enable = true;
  common.syncthing.enable = false;
  desktop = {
    enable = true;
    guestSetup.enable = false;
    kanata.enable = false;
  };

  system.stateVersion = "24.11";
}
