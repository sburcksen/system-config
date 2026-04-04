{ pkgs, modules, lib, ... }:

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
    jellyfin = let 
      dir = "/data_ssd/jellyfin";
    in {  
      enable = true;

      openFirewall = true;
      user = "jellyfin";
      group = "jellyfin";

      dataDir = "${dir}/data";
      configDir = "${dir}/config";
      logDir = "${dir}/log";
      cacheDir = "${dir}/cache";

      hardwareAcceleration = {
        enable = true;
	type = "qsv";
	device = "/dev/dri/renderD128";
      };

      transcoding = {
        enableHardwareEncoding = true;
	throttleTranscoding = true;
	maxConcurrentStreams = 2;
	
	hardwareEncodingCodecs = {
	  hevc = true;
	  av1 = false;
	};

	hardwareDecodingCodecs = {
	  h264 = true;
	  hevc = true;
	  hevc10bit = true;
	  vp9 = true;
	  av1 = true;
	};
      };
    };

    # E-book manager
    calibre-web = {
      enable = true;
      listen.ip = "0.0.0.0";
      listen.port = 8083;
      openFirewall = true;
      options = {
	calibreLibrary = "/data_ssd/calibre/library";
	enableBookUploading = true;
	enableBookConversion = true;
      };
    };

    # EBooks
    readarr = {
      enable = true;
      openFirewall = true;
      settings = {
        auth = {
	  method = "Basic";
	  required = "DisabledForLocalAddresses";
	};
      };
    };
  };

  # For Jellyfin Hardware encoding
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # modern (iHD)
      vpl-gpu-rt
      #intel-vaapi-driver # older (i965)
      #intel-compute-runtime
      #intel-compute-runtime-legacy1
    ];
  };
  users.users.jellyfin.extraGroups = [ "render" "video" ];
  #systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  #environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  systemd.services.jellyfin.serviceConfig = {
    ProtectSystem = lib.mkForce "full";
    ProtectHome = true;
    PrivateTmp = true;
    NoNewPrivileges = true;
  };

  networking.firewall.allowedTCPPorts = [
    5232 # Radicale
    8080 # Trilium
    8123 # HomeAssistant
  ];

}
