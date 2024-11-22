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
        MusicFolder = "/run/media/hdd/Music/Tagged";
        BaseUrl = "http://192.168.1.12:4533";
        "Scanner.GroupAlbumReleases" = true;
        "CoverArtPriority" = "cover.*, folder.*, front.*, external, embedded";
        "ArtistArtPriority" = "external, embedded, artist.*";
        "LastFM.Enabled" = true;
        "LastFM.ApiKey" = "f81c6460ac9d3e6a9dfc1530d7b40e27";
        "LastFM.Secret" = "782faf0dfd480a9a3698e17a40de2e5b";
        "Spotify.Enabled" = true;
        "Spotify.ID" = "6d8472b3b085410493d783ab39317539";
        "Spotify.Secret" = "3a0dfc57c90b413b83844b6cea31458d";
        "EnableSharing" = true;
      };
    };
  };
}
