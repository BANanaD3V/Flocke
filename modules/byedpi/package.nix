{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.byedpi;
in {
  options.services.byedpi = {
    enable = mkEnableOption "byedpi socks4 server";

    openFirewall = mkOption {
      type = types.bool;

      default = false;

      description = "Whether to open a firewalls port.";
    };

    commandLine = mkOption {
      type = types.str;

      description = "Command Line";
    };

    address = mkOption {
      type = types.str;

      default = "127.0.0.1";

      description = "Listening IP, default is set to 127.0.0.1 for sake of security";
    };

    socksPort = mkOption {
      type = types.port;

      default = 1080;

      example = 8080;

      description = "Listening port";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.byedpi = {
      description = "Bypass DPI socks4 server";

      requires = ["network.target"];

      wantedBy = ["default.target"];
      serviceConfig = {
        ExecStart = "${pkgs.byedpi}/bin/ciadpi --ip ${config.services.byedpi.address} -p ${
          toString config.services.byedpi.socksPort
        } ${config.services.byedpi.commandLine} ";
        Type = "exec";
        PIDFile = "/run/ciadpi.pid";
        ExecReload = "/bin/kill -HUP $MAINPID";
        Restart = "always";
        RestartSec = "5s";
      };
    };

    networking.firewall = {
      allowedTCPPorts = with cfg; optionals openFirewall [socksPort];
    };

    environment = {systemPackages = [pkgs.byedpi];};
  };
}
