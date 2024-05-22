{
  lib,
  config,
  ...
}: {
  options.server.caddy.enable = lib.mkEnableOption "Enable caddy" // {default = config.server.enable;};
  config = lib.mkIf config.server.caddy.enable {
    services.caddy = {
      enable = true;
      virtualHosts = {
        "invidious.banana.is-cool.dev".extraConfig = ''
          reverse_proxy http://0.0.0.0:9000
        '';
        "searxng.banana.is-cool.dev".extraConfig = ''
          reverse_proxy http://0.0.0.0:7666
        '';
        "0x0.banana.is-cool.dev".extraConfig = ''
          reverse_proxy http://0.0.0.0:5555
        '';
      };
    };
  };
}
