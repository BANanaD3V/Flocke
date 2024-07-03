{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.home-manager.colorscheme
    == "flexoki") {
    colorScheme = {
      slug = "flexoki";
      name = "Flexoki";
      author = "Steph Ango";
      palette = {
        base00 = "#100F0F";
        base01 = "#1C1B1A";
        base02 = "#282726";
        base03 = "#373636";
        base04 = "#403E3C";
        base06 = "#575653";
        base07 = "#878580";
        base05 = "#CECDC3";
        base08 = "#D14C40";
        base09 = "#DA702C";
        base0A = "#D0A215";
        base0B = "#879A39";
        base0C = "#3AA99F";
        base0D = "#4385BE";
        base0E = "#8B7EC8";
        base0F = "#CE5D97";
      };
    };
    home-manager.wallpaper = "ship-2.png";
  };
}
