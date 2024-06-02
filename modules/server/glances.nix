{
  lib,
  config,
  pkgsStable,
  ...
}: {
  options.server.glances.enable = lib.mkEnableOption "Enable glances" // {default = config.server.enable;};
  config = lib.mkIf config.server.glances.enable {
    environment.systemPackages = with pkgsStable; [glances];
    systemd.services.glances = {
      enable = true;
      description = "Glances Web ui";
      serviceConfig = {
        Restart = "on-abort";
        Type = "simple";
        ExecStart = "${pkgsStable.glances}/bin/glances -w";
      };
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
    };
  };
}
