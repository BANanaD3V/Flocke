{
  lib,
  pkgs,
  config,
  ...
}: {
  options.server.cloudflared.enable = lib.mkEnableOption "Enable cloudflared" // {default = config.server.enable;};
  config = lib.mkIf config.server.cloudflared.enable {
    environment.systemPackages = with pkgs; [cloudflared];
    systemd.services.cloudflared = {
      after = ["syslog.target" "network-online.target"];
      description = "Cloudflared DoH Proxy";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "simple";
        User = "cloudflared";
        ExecStart = "${pkgs.cloudflared}/bin/cloudflared proxy-dns --port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query";
        Restart = "on-failure";
        RestartSec = 10;
        KillMode = "process";
      };
    };
    services.cloudflared = {
      enable = true;
    };
  };
}
