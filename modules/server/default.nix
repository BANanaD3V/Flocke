{
  lib,
  config,
  host,
  ...
}: {
  options.server.enable = lib.mkEnableOption "Enable server suite" // {default = false;}; # // {default = host == "server";};
  imports = [
    ./searx.nix
    ./nextcloud.nix
    ./scrutiny.nix
    ./0x0.nix
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
  ];
  config = lib.mkIf config.server.enable {
    virtualisation.docker = {
      enable = true;
      extraOptions = "--registry-mirror https://mirror.gcr.io";
    };
    services.docker-compose.enable = true;
  };
}
