{ ... }:

{
  networking.hostName = "laptop";

  imports = [
    ./hardware.nix
    ./guest-setup.nix
    ./kanata.nix
    ../../modules
  ];

  common.enable = true;
  desktop.enable = true;

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
}
