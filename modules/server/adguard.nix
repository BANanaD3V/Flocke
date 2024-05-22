{
  lib,
  config,
  ...
}: {
  options.server.adguardhome.enable = lib.mkEnableOption "Enable AdGuardHome" // {default = config.server.enable;};
  config = lib.mkIf config.server.adguardhome.enable {
    services.adguardhome = {
      enable = true;
      port = 8082;
      settings = {
        http.address = "0.0.0.0:8082";
        schema_version = 21;
        dns = {
          ratelimit = 0;
          bind_hosts = ["0.0.0.0"];
          bootstrap_dns = [
            "9.9.9.10"
            "149.112.112.10"
            "2620:fe::10"
            "2620:fe::fe:10"
          ];
          upstream_dns = [
            "1.1.1.1"
            "1.0.0.1"
          ];
        };
      };
    };
  };
}
