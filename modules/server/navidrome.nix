{
  pkgs,
  config,
  lib,
  ...
}: let
  settingsFormat = pkgs.formats.keyValue {
    mkKeyValue = lib.generators.mkKeyValueDefault {} " ";
    listsAsDuplicateKeys = true;
  };
in {
  options.server.navidrome.enable = lib.mkEnableOption "Enable navidrome" // {default = config.server.enable;};
  config = lib.mkIf config.server.navidrome.enable {
    systemd.services.gonic.serviceConfig.ExecStart = let
      # these values are null by default but should not appear in the final config
      filteredSettings = lib.filterAttrs (n: v: !((n == "tls-cert" || n == "tls-key") && v == null)) config.services.gonic.settings;
    in
      lib.mkForce "${(
        pkgs.gonic.overrideAttrs
        (old: {
          vendorHash = "sha256-FLndulcjHZQWEyTP1+lCBTdCBNemNtEh6j3oGH5E6wo=";
          src = pkgs.fetchFromGitHub {
            owner = "danielepintore";
            repo = "gonic";
            rev = "2029a6e9a24799f937281c2b8d74ec19b21187cc";
            sha256 = "sha256-1CHiPfBlQFWDVa3qwaXJ4yk01W2Yhgef+9eMg/1AdfE=";
          };
        })
      )}/bin/gonic -config-path ${settingsFormat.generate "gonic" filteredSettings}";
    services.gonic = {
      enable = true;

      settings = {
        multi-value-genre = "multi";
        multi-value-artist = "multi";
        multi-value-album-artist = "multi";
        cache-path = "/var/cache/gonic";
        listen-addr = "127.0.0.1:4747";
        music-path = "/run/media/hdd/Music/Tagged_old";
        podcast-path = "/run/media/hdd/Music/Podcasts";
        playlists-path = "/run/media/hdd/Music/Playlists";
      };
    };

    services.navidrome = {
      enable = false;
      # package = pkgs.callPackage ../../pkgs/navidrome.nix {
      #   buildGo123Module = pkgs.buildGoModule.override {go = pkgs.go_1_23;};
      # };
      settings = {
        MusicFolder = "/run/media/hdd/Music/Tagged";
        BaseUrl = "https://navidrome.banana.is-cool.dev";
        "Scanner.GroupAlbumReleases" = true;
        "CoverArtPriority" = "cover.*, folder.*, front.*, external, embedded";
        "EnableExternalServices" = true;
        "ArtistArtPriority" = "external";
        "LastFM.Enabled" = true;
        "LastFM.ApiKey" = "0387ee4c87aa6c910231fd3f96b6d284";
        "LastFM.Secret" = "ee9013122ba1ec79dc24c6955c692bef";
        "Spotify.Enabled" = true;
        "Spotify.ID" = ''5ef38d9026054416a3fe07e3264ee7cd'';
        "Spotify.Secret" = ''2735c70d32874034a274a2f1c199e079'';
        "EnableSharing" = true;
        "SearchFullString" = true;
      };
    };
  };
}
