{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.server.jellyfin.enable = lib.mkSubOption config.server.enable "Jellyfin";

  config = lib.mkIf config.server.jellyfin.enable {
    users.groups.media = { };

    services.jellyfin =
      let
        dir = "/data_ssd/jellyfin";
      in
      {
        enable = true;

        openFirewall = true;
        user = "jellyfin";
        group = "media";

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

    users.users.jellyfin.extraGroups = [
      "render"
      "video"
    ];
    #systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
    #environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

    systemd.services.jellyfin.serviceConfig = {
      ProtectSystem = lib.mkForce "full";
      ProtectHome = true;
      PrivateTmp = true;
      NoNewPrivileges = true;
    };

    services.radarr = {
      enable = true;
      openFirewall = true;
      user = "radarr";
      group = "media";
      dataDir = "/data_ssd/radarr";
      settings = {
        auth = {
          method = "Basic";
          required = "DisabledForLocalAddresses";
        };
      };
    };

    services.sonarr = {
      enable = true;
      openFirewall = true;
      user = "sonarr";
      group = "media";
      dataDir = "/data_ssd/sonarr";
      settings = {
        auth = {
          method = "Basic";
          required = "DisabledForLocalAddresses";
        };
      };
    };

    services.readarr = {
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
}
