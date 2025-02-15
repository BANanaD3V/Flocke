{
  config,
  username,
  ...
}: {
  imports = [
    ./base.nix
    ./sops.nix
    ./docker-compose.nix
    ./direnv.nix
    ./nix.nix
    ./hyprland.nix
    ./steam.nix
    ./gamemode.nix
    ./byedpi
    ./zapret
    ./syncthing.nix
    ./hardware
    ./server
  ];
}
