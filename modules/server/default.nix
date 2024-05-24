{
  lib,
  config,
  host,
  ...
}: {
  options.server.enable = lib.mkEnableOption "Enable server suite" // {default = host == "server";};
  imports = [
    ./searx.nix
    ./scrutiny.nix
    ./0x0.nix
    ./postgres.nix
    ./transmission.nix
    ./adguard.nix
    ./glances.nix
    ./caddy.nix
    ./speedtest.nix
    ./homepage.nix
    ./jellyfin.nix
    ./invidious.nix
  ];
  config = lib.mkIf config.server.enable {
    virtualisation.docker.enable = true;
    services.docker-compose.enable = true;
  };
}
