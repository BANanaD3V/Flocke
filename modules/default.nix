{
  config,
  username,
  ...
}: {
  imports = [
    ./base.nix
    ./sops.nix
    ./docker-compose.nix
    ./nix.nix
    ./hyprland.nix
    ./steam.nix
    ./gamemode.nix
    ./byedpi
    ./zapret.nix
    ./syncthing.nix
    ./hardware
    ./server
  ];
}
