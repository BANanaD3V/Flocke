{
  lib,
  config,
  pkgs,
  ...
}: {
  options.server.glances.enable = lib.mkEnableOption "Enable glances" // {default = config.server.enable;};
  config = lib.mkIf config.server.glances.enable {
    environment.systemPackages = with pkgs; [glances];
    systemd.services.glances = {
      enable = true;
      description = "Glances Web ui";
      serviceConfig = {
        Restart = "on-abort";
        Type = "simple";
        ExecStart = "${pkgs.glances}/bin/glances -w";
      };
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
    };
  };
}
