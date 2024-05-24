{
  config,
  pkgs,
  lib,
  ...
}: {
  options.server.postgres.enable = lib.mkEnableOption "Enable postgres" // {default = config.server.enable;};
  config = lib.mkIf config.server.postgres.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      ensureDatabases = ["postgres" "invidious"];
      ensureUsers = [
        {
          name = "postgres";
          ensureDBOwnership = true;
        }
        {
          name = "invidious";
          ensureDBOwnership = true;
        }
      ];
      authentication = pkgs.lib.mkForce ''
        # TYPE  DATABASE        USER            ADDRESS                 METHOD
        local   all             all                                     trust
        host    all             all             127.0.0.1/32            md5
        host    all             all             ::1/128                 md5
      '';
    };
  };
}
