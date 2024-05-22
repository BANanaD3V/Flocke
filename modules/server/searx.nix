{
  lib,
  config,
  ...
}: {
  options.server.searx.enable = lib.mkEnableOption "Enable searx" // {default = config.server.enable;};
  config = lib.mkIf config.server.searx.enable {
    services.searx = {
      enable = true;
      settings = {
        server = {
          port = 7666;
          bind_address = "0.0.0.0";
          image_proxy = false;
          secret_key = "CHANGE_W_SOPS_LATER";
          limiter = false;
          default_theme = "simple";
        };
        search = {
          safe_search = 0;
          autocomplete = "duckduckgo";
        };
        ui = {
          hotkeys = "vim";
          center_alignment = true;
          infinite_scroll = true;
        };
        enabled_plugins = [
          "Hash plugin"
          "Self information"
          "Tracker URL remover"
          "Hostname replace"
          "Autodetect search language"
        ];
        hostname_replace = {
          "(.*\.)?youtube\.com$" = "invidious.banana.is-cool.dev";
          "(.*\.)?youtu\.be$" = "invidious.banana.is-cool.dev";
        };
        engines = [
          {
            name = "brave";
            disabled = true;
          }
          {
            name = "duckduckgo";
            disabled = true;
          }
          {
            name = "qwant";
            disabled = true;
          }
          {
            name = "dictzone";
            disabled = true;
          }
          {
            name = "lingva";
            disabled = true;
          }
          {
            name = "wikidata";
            disabled = true;
          }
        ];
      };
    };
  };
}
