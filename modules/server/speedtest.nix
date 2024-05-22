{
  lib,
  config,
  ...
}: {
  options.server.speedtest.enable = lib.mkEnableOption "Enable speedtest" // {default = config.server.enable;};
  config = lib.mkIf config.server.speedtest.enable {
    services.docker-compose.services.speedtest = {
      name = "speedtest";
      composeContents = {
        version = "3.4";
        services = {
          speedtest-tracker = {
            container_name = "speedtest-tracker";
            ports = ["8765:80" "8766:443"];
            environment = ["PUID=1000" "PGID=1000" "DB_CONNECTION=sqlite"];
            volumes = ["./config:/config" "./ssl:/config/keys"];
            image = "lscr.io/linuxserver/speedtest-tracker:latest";
            restart = "unless-stopped";
          };
        };
      };
      systemd-service = {
        enable = true;
      };
    };
  };
}
