{ pkgs, modules, ... }:

{
  networking.hostName = "nas";

  imports = with modules; [
    ./hardware.nix
    ./docker.nix
    common.default
  ];

  # PowerManagement
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "yes";
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
