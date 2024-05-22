{
  pkgs,
  lib,
  config,
  ...
}: {
  options.server.scrutiny.enable = lib.mkEnableOption "Enable scrutiny" // {default = config.server.enable;};
  config = lib.mkIf config.server.scrutiny.enable {
    environment.systemPackages = with pkgs; [
      smartmontools
    ];
    services.scrutiny = {
      enable = true;
      settings = {
        web.listen = {
          host = "0.0.0.0";
          port = 8083;
        };
      };
      collector = {
        enable = true;
        settings.devices = [
          {
            device = "/dev/sda";
            type = "scsi";
          }
          {
            device = "/dev/nvme0";
            type = "nvme";
          }
        ];
      };
    };
  };
}
