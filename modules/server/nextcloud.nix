{
  pkgs,
  config,
  ...
}: let
  package = "nextcloud29";
in {
  services.nextcloud = {
    enable = true;
    package = pkgs.${package};
    extraApps = {
      inherit (pkgs."${package}Packages".apps) notes bookmarks maps tasks spreed previewgenerator phonetrack memories calendar contacts forms;
    };
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
}
