{
  config,
  lib,
  ...
}: {
  options.server.pufferpanel.enable = lib.mkEnableOption "Enable pufferpanel" // {default = config.server.enable;};
  config = lib.mkIf config.server.pufferpanel.enable {
    virtualisation.oci-containers.containers.pufferpanel = {
      image = "pufferpanel/pufferpanel:latest";
      # ports = [
      #   "8090:8080"
      #   "5657:5657"
      #   "25545:25545"
      # ];
      environment = {
        PUFFER_DAEMON_CONSOLE_BUFFER = "1000";
        PUFFER_PANEL_REGISTRATIONENABLED = "false";
      };
      volumes = [
        "/etc/pufferpanel:/etc/pufferpanel"
        "/var/lib/pufferpanel:/var/lib/pufferpanel"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
      extraOptions = [
        "--pull=always"
        "--network=host"
      ];
    };
  };
}
