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
    ./byedpi
    ./zapret.nix
    ./hardware
    ./server
  ];
}
