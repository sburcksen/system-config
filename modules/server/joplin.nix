{
  pkgs,
  config,
  lib,
  ...
}: let
  storagePath = "/data_ssd/joplin";
in {
  options.server.joplin.enable = lib.mkSubOption config.server.enable "Joplin server";

  config = lib.mkIf config.server.joplin.enable {
    # Ensure the custom directories exist with correct permissions before starting containers
    systemd.tmpfiles.rules = [
      "d ${storagePath}/postgres-data 0700 999 999 -" # 999 is standard for postgres uid/gid
    ];

    systemd.services.create-joplin-network = {
      description = "Create Docker network for Joplin";
      after = ["docker.service"];
      wants = ["docker.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        ${pkgs.docker}/bin/docker network inspect joplin >/dev/null 2>&1 || \
        ${pkgs.docker}/bin/docker network create joplin
      '';
    };

    virtualisation.oci-containers.backend = "docker";

    virtualisation.oci-containers.containers = {
      joplin-db = {
        image = "postgres:16";
        environment = {
          POSTGRES_DB = "joplin";
          POSTGRES_USER = "joplin";
          # Disables passwords completely for this container
          POSTGRES_HOST_AUTH_METHOD = "trust";
        };
        volumes = [
          "${storagePath}/postgres-data:/var/lib/postgresql/data"
        ];
        extraOptions = ["--network=joplin"];
      };

      joplin-server = {
        image = "joplin/server:latest";
        ports = ["22300:22300"];
        dependsOn = ["joplin-db"];
        environment = {
          APP_PORT = "22300";
          APP_BASE_URL = "http://nas.lan:22300";
          DB_CLIENT = "pg";
          POSTGRES_DATABASE = "joplin";
          POSTGRES_USER = "joplin";
          POSTGRES_HOST = "joplin-db";
        };
        extraOptions = ["--network=joplin"];
      };
    };
  };
}
