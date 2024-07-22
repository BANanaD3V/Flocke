{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.home-manager.colorscheme
    == "flexoki-light") {
    colorScheme = {
      slug = "flexoki-light";
      name = "Flexoki light";
      author = "Steph Ango";
      palette = {
        base00 = "#FFFCF0";
        base01 = "#F2F0E5";
        base02 = "#E6E4D9";
        base03 = "#DAD8CE";
        base04 = "#CECDC3";
        base06 = "#B7B5AC";
        base07 = "#6F6E69";
        base05 = "#100F0F";
        base08 = "#AF3029";
        base09 = "#BC5215";
        base0A = "#AD8301";
        base0B = "#66800B";
        base0C = "#24837B";
        base0D = "#205EA6";
        base0E = "#5E409D";
        base0F = "#A02F6F";
      };
    };
    home-manager.wallpaper = "hallstat.png";
  };
}
