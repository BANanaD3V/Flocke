{
  config,
  username,
  pkgs,
  lib,
  ...
}: {
  options.server.invidious.enable = lib.mkEnableOption "Enable invidious" // {default = config.server.enable;};
  config = lib.mkIf config.server.invidious.enable {
    services.invidious = {
      enable = true;
      package = pkgs.invidious;
      port = 9000;
      database.createLocally = false;
      # hmacKeyFile = config.sops.secrets."invidious/hmac_key".path;
      settings = {
        domain = "invidious.banana.is-cool.dev";
        https_only = true;
        external_port = 443;
        check_tables = true;
        db = {
          url = "postgres://invidious:invidious@localhost:5432/invidious";
        };
        statistics_enabled = true;
        admins = ["banana"];
        default_user_preferences = {
          default_home = "Subscriptions";
          feed_menu = ["Subscriptions" "Playlists"];
        };
        top_enabled = false;
        related_videos = false;
        popular_enabled = false;
      };
    };

    sops = {
      secrets."invidious/hmac_key" = {
        mode = "444";
      };
    };
  };
}
