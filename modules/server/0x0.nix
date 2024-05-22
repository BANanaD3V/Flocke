{
  lib,
  config,
  ...
}: {
  options.server."0x0".enable = lib.mkEnableOption "Enable 0x0" // {default = config.server.enable;};
  config = lib.mkIf config.server."0x0".enable {
    services.docker-compose.services."0x0" = {
      name = "0x0";
      composeContents = {
        version = "3.9";
        services = {
          app = {
            image = "lastradev/0x0:latest";
            container_name = "app";
            environment = {
              DATABASE_URI = "postgresql://toor:toor@db/db";
              FLASK_APP = "fhost";
              APP_PORT = 8080;
              MAX_SIZE = 512;
            };
            volumes = ["./data/up:/app/up"];
            expose = [8080];
            depends_on = {db = {condition = "service_healthy";};};
          };
          db = {
            image = "postgres:alpine3.15";
            container_name = "postgres";
            environment = {
              POSTGRES_PASSWORD = "toor";
              POSTGRES_USER = "toor";
              POSTGRES_DB = "db";
            };
            expose = [5432];
            volumes = ["./data/db:/var/lib/postgresql/data"];
            healthcheck = {
              test = ["CMD-SHELL" "pg_isready -d db -U toor"];
              interval = "10s";
              timeout = "5s";
              retries = 5;
            };
          };
          nginx = {
            image = "lastradev/0x0-nginx:latest";
            container_name = "nginx";
            volumes = ["./data/up:/etc/nginx/html/up"];
            environment = {MAX_SIZE = "512M";};
            ports = ["5555:80"];
            depends_on = ["app"];
          };
        };
      };
      systemd-service = {
        enable = true;
      };
    };
  };
}
