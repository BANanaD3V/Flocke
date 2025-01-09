{lib, ...}: {
  options.home-manager = {
    colorscheme = lib.mkOption {
      type = lib.types.enum ["catppuccin" "biscuit" "cuterose" "flexoki-dark" "flexoki-light" "twilight"];
      default = "catppuccin";
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
    };
  };
}
