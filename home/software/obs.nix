{
  config,
  pkgs,
  ...
}: {
  programs = {
    obs-studio = {
      enable = config.home-manager.obs.enable;
      plugins = with pkgs.obs-studio-plugins; [
        obs-gstreamer
        obs-vaapi
        obs-command-source
        obs-webkitgtk
        obs-pipewire-audio-capture
        wlrobs
      ];
    };
  };
}
