{
  config,
  useremail,
  lib,
  ...
}: {
  options.server.nginx.enable = lib.mkEnableOption "Enable nginx" // {default = config.server.enable;};
  config = lib.mkIf config.server.nginx.enable {
    services.nginx.enable = true;
    services.nginx.clientMaxBodySize = "512M";
    services.nginx.virtualHosts = {
      "invidious.banana.is-cool.dev" = {
        addSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:9000";
        };
      };
      "searxng.banana.is-cool.dev" = {
        addSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:7666";
        };
      };

      "0x0.banana.is-cool.dev" = {
        addSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:5555";
        };
      };
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = useremail;
    };
  };
}
