{
  pkgs,
  inputs,
  config,
  spicetify-nix,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "custom";

    customColorScheme = with config.colorScheme.palette; {
      accent = base0B;
      accent-active = base0B;
      accent-inactive = base01;
      banner = base0B;
      border-active = base0B;
      border-inactive = base02;
      header = base03;
      highlight = base03;
      main = base01;
      notification = base0D;
      notification-error = base08;
      subtext = base04;
      text = base05;
    };
    enabledExtensions = with spicePkgs.extensions; [
      autoSkipVideo
      shuffle
      beautifulLyrics
      playlistIcons
      seekSong
      adblock
      fullAppDisplay
      loopyLoop
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
  };
}
