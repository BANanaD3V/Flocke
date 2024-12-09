{
  lib,
  config,
  pkgs,
  ...
}: {
  options.server.forgejo.enable = lib.mkEnableOption "Enable forgejo" // {default = config.server.enable;};
  config = lib.mkIf config.server.forgejo.enable {
    services.forgejo = {
      enable = true;
      lfs.enable = true;
      settings = {
        session.COOKIE_SECURE = true;
        service.DISABLE_REGISTRATION = true;
        server = {
          HTTP_PORT = 3333;
          DOMAIN = "forgejo.banana.is-cool.dev";
          ROOT_URL = "https://forgejo.banana.is-cool.dev";
          DISABLE_SSH = true;
        };
      };
    };
  };
}
