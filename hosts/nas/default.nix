{ pkgs, modules, ... }:

{
  networking.hostName = "nas";

  imports = with modules; [
    ./hardware.nix
    common.default
  ];

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

  # Self-hosted services
  services = {
    # Calendar and Contacts Server
    radicale = {
      enable = true;
      settings = {
        server.hosts = [ "0.0.0.0:5232" ];
        storage.filesystem_folder = "/data_ssd/radicale/collections"; 
        auth = {
          type = "htpasswd";
	  htpasswd_filename = "/data_ssd/radicale/users";
	  htpasswd_encryption = "bcrypt";
        };
      };
    };

    # Note-taking application  
    trilium-server = {
      enable = true;
      dataDir = "/data_ssd/trilium";
      host = "0.0.0.0";
      port = 8080;
    };

    # Media Server

  };

  networking.firewall.allowedTCPPorts = [
    8123 # HomeAssistant
    8080 # Trilium
    5232 # Radicale
  ];

}
