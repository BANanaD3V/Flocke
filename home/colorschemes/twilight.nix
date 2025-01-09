{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.home-manager.colorscheme
    == "twilight") {
    colorScheme = {
      slug = "twilight";
      name = "Twilight";
      author = "David Hart (https://github.com/hartbit)";
      palette = {
        base00 = "#121212";
        base01 = "#323537";
        base02 = "#464b50";
        base03 = "#5f5a60";
        base04 = "#838184";
        base05 = "#a7a7a7";
        base06 = "#c3c3c3";
        base07 = "#ffffff";
        base08 = "#cf6a4c";
        base09 = "#cda869";
        base0A = "#f9ee98";
        base0B = "#8f9d6a";
        base0C = "#afc4db";
        base0D = "#7587a6";
        base0E = "#9b859d";
        base0F = "#9b703f";
      };
    };
    home-manager.wallpaper = "nature.png";
  };
}
