{
  pkgs,
  lib,
  config,
  ...
}: {
  options.server.transmission.enable = lib.mkEnableOption "Enable transmission" // {default = config.server.enable;};
  config = lib.mkIf config.server.transmission.enable {
    services.transmission = {
      enable = true;
      package = pkgs.transmission_4;
      settings = {
        rpc-bind-address = "0.0.0.0";
        rpc-port = 9091;
        rcp-whitelist-enabled = 0;
        rpc-whitelist = "*.*.*.*";
      };
    };
  };
}
