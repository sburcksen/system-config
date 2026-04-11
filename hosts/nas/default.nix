{
  pkgs,
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

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };

  networking.firewall.allowedTCPPorts = [
    8123 # HomeAssistant
  ];
}
