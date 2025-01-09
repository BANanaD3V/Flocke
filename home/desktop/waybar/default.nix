{
  pkgs,
  lib,
  config,
  inputs,
  host,
  ...
}:
with lib; let
  cfg = import ./rices/minimal/config.nix {inherit lib config;};
  style = import ./rices/minimal/style.nix {inherit config;};
  spotify_now_playing = import ./scripts/spotify_now_playing.nix {inherit pkgs host;};
  cava_waybar = import ./scripts/cava_waybar.nix {inherit pkgs;};
in {
  config = lib.mkIf config.home-manager.waybar.enable {
    home.packages = with pkgs; [
      networkmanagerapplet
      blueman
      spotify_now_playing
      cava_waybar
    ];

    programs.waybar = {
      enable = true;
      # package = inputs.waybar.packages.${pkgs.system}.waybar;
      settings = cfg;
      style = style;
    };
  };
}
