{
  pkgs,
  config,
  lib,
  ...
}: {
  options.server.navidrome.enable = lib.mkEnableOption "Enable navidrome" // {default = config.server.enable;};
  config = lib.mkIf config.server.navidrome.enable {
    services.navidrome = {
      enable = true;
      settings = {
        MusicFolder = "/run/media/hdd/Music_beets";
        BaseUrl = "http://192.168.1.12:4533";
        "Scanner.GroupAlbumReleases" = true;
        "CoverArtPriority" = "cover.*, folder.*, front.*, external, embedded";
        "LastFM.Enabled" = false;
        "EnableSharing" = true;
      };
    };
  };
}
