{lib, ...}: {
  options.home-manager = {
    colorscheme = lib.mkOption {
      type = lib.types.enum ["catppuccin" "biscuit" "cuterose" "flexoki-dark" "flexoki-light"];
      default = "catppuccin";
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
    };
  };
}
