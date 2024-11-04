{
  pkgs,
  lib,
  config,
  ...
}: let
  package = "nextcloud30";
in {
  options.server.nextcloud.enable = lib.mkEnableOption "Enable nextcloud" // {default = config.server.enable;};
  config = lib.mkIf config.server.nextcloud.enable {
    services.nextcloud = {
      enable = true;
      package = pkgs.${package};
      # extraApps = {
      #   inherit (pkgs."${package}Packages".apps) notes bookmarks maps tasks spreed phonetrack memories calendar contacts forms;
      # };
      hostName = "nextcloud.banana.is-cool.dev";
      config.adminpassFile = "/etc/nextcloud-admin-pass";
      https = true;
      settings = {
        trusted_domains = [
          "nextcloud.banana.is-cool.dev"
        ];
      };
    };
    services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
      forceSSL = true;
      enableACME = true;
    };
  };
}
