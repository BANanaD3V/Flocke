{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.home-manager.colorscheme
    == "cuterose") {
    colorScheme = {
      slug = "cuterose";
      name = "Cuterose";
      author = "Amy Rose";
      palette = {
        base00 = "#1e1e20";
        base01 = "#303033";
        base02 = "#414145";
        base03 = "#4f4f54";
        base04 = "#5b5b61";
        base05 = "#f5e0dc";
        base06 = "#e0e0e0";
        base07 = "#f5e0dc";
        base08 = "#a8868a";
        base09 = "#dca279";
        base0A = "#dca279";
        base0B = "#dd9999";
        base0C = "#a8868a";
        base0D = "#dd9999";
        base0E = "#ac9ec5";
        base0F = "#a8868a";
      };
    };
    home-manager.wallpaper = "after_the_fall_camping.jpg";
  };
}
