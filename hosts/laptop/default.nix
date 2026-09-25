{...}: {
  networking.hostName = "laptop";

  imports = [
    ./hardware.nix
    ../../modules
  ];

  common.enable = true;
  common.syncthing.enable = false;
  desktop.enable = true;
  desktop.guestSetup.enable = false;

  # Overwrite default logind behaviour
  services.logind.settings.Login = {
    # Lid behavior is handled by Hyprland
    HandleLidSwitch = "ignore";
  };

  # PowerManagement
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  system.stateVersion = "24.11";
}
