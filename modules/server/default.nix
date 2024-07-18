{
  lib,
  config,
  host,
  ...
}: {
  options.server.enable = lib.mkEnableOption "Enable server suite" // {default = host == "server";};
  imports = [
    ./cloudflared.nix
    ./navidrome.nix
    ./searx.nix
    ./nextcloud.nix
    ./scrutiny.nix
    ./0x0.nix
    ./slskd.nix
    ./postgres.nix
    ./transmission.nix
    ./adguard.nix
    ./glances.nix
    # ./caddy.nix
    ./nginx.nix
    ./speedtest.nix
    ./homepage.nix
    ./jellyfin.nix
    ./invidious.nix
    ./pufferpanel.nix
    ./github-runners.nix
  ];
  config = lib.mkIf config.server.enable {
    virtualisation.docker = {
      enable = true;
      extraOptions = "--registry-mirror https://mirror.gcr.io";
    };
    virtualisation.oci-containers.backend = "docker";
    services.docker-compose.enable = true;
  };
}
