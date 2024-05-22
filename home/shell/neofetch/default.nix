{
  config,
  lib,
  host,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
  ];

  config = lib.mkIf (host
    != "server") {
    home.packages = with pkgs; [
      neofetch
    ];
    # Import config

    xdg.configFile."neofetch/logo" = {
      source = ./logo;
      recursive = true;
      executable = true;
    };
  };
}
