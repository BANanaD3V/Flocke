{
  lib,
  config,
  pkgs,
  ...
}: {
  options.server.github-runners.enable = lib.mkEnableOption "Enable github-runners" // {default = config.server.enable;};
  config = lib.mkIf config.server.github-runners.enable {
    services.github-runners = {
      nixos-config = {
        enable = true;
        name = "nixos-config";
        url = "https://github.com/BANanaD3V/Flocke/";
        tokenFile = config.sops.secrets."github_runners/nixos_config".path;
      };
    };
    sops = {
      secrets."github_runners/nixos_config" = {
        mode = "444";
      };
    };
  };
}
