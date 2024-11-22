{
  lib,
  config,
  ...
}: {
  options.server.immich.enable = lib.mkEnableOption "Enable immich" // {default = config.server.enable;};
  config = lib.mkIf config.server.immich.enable {
    services.immich = {
      enable = true;
      host = "0.0.0.0";
      database = {
        # host = "/dev/null";
        enable = true;
      };
      mediaLocation = "/run/media/hdd/immich";
    };
  };
}
