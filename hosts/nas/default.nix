{
  ...
}:

{
  networking.hostName = "nas";

  imports = [
    ./hardware.nix
    ../../modules
  ];

  common.enable = true;
  server.enable = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  virtualisation.docker.enable = true;
  users.users.sburcksen.extraGroups = [ "docker" ];

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [
    8123 # HomeAssistant
  ];

  system.stateVersion = "24.11";
}
