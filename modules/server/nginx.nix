{
  config,
  useremail,
  lib,
  ...
}: {
  options.server.nginx.enable = lib.mkEnableOption "Enable nginx" // {default = config.server.enable;};
  config = lib.mkIf config.server.nginx.enable {
    services.nginx = {
      enable = true;
      proxyTimeout = "600s";
      clientMaxBodySize = "512M";
      recommendedTlsSettings = true;
      recommendedZstdSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      recommendedBrotliSettings = true;
      virtualHosts = {
        "forgejo.banana.is-cool.dev" = {
          addSSL = true;
          enableACME = true;
          kTLS = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:3333";
          };
        };

        "immich.banana.is-cool.dev" = {
          addSSL = true;
          enableACME = true;
          kTLS = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:2283";
          };
        };
        "syncthing.banana.is-cool.dev" = {
          addSSL = true;
          enableACME = true;
          kTLS = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8384";
          };
        };
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

        "gonic.banana.is-cool.dev" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:4747";
          };
        };

        "nghe.banana.is-cool.dev" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:4444";
          };
        };

        "navidrome.banana.is-cool.dev" = {
          addSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:4533";
          };
        };
      };
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = useremail;
    };
  };
}
