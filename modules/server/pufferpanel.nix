{
  config,
  lib,
  ...
}: {
  options.server.pufferpanel.enable = lib.mkEnableOption "Enable pufferpanel" // {default = config.server.enable;};
  config = lib.mkIf config.server.pufferpanel.enable {
    services.pufferpanel = {
      enable = true;
      environment = {
        PUFFER_WEB_HOST = ":9005";
      };
    };
  };
}
