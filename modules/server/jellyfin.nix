{
  lib,
  config,
  ...
}: {
  options.server.jellyfin.enable = lib.mkEnableOption "Enable jellyfin" // {default = config.server.enable;};
  config = lib.mkIf config.server.jellyfin.enable {
    services.jellyfin.enable = true;
  };
}
