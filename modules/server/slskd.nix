{
  config,
  lib,
  ...
}: {
  options.server.slskd.enable = lib.mkEnableOption "Enable slskd" // {default = config.server.enable;};
  config = lib.mkIf config.server.slskd.enable {
    services.slskd = {
      enable = true;
      domain = null;
      environmentFile = config.sops.secrets."soulseek.env".path;
      # openFirewall = true;
      settings = {
        directories.downloads = "/run/media/hdd/Music";
        shares.directories = [
          "/run/media/hdd/Music_beets"
        ];
      };
    };
    systemd.services.slskd.serviceConfig.ReadOnlyPaths = lib.mkForce [];
    sops = {
      secrets."soulseek.env" = {
        mode = "444";
      };
    };
  };
}
