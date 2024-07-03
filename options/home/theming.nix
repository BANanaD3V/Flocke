{lib, ...}: {
  options.home-manager = {
    colorscheme = lib.mkOption {
      type = lib.types.enum ["catppuccin" "biscuit" "cuterose" "flexoki"];
      default = "catppuccin";
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
    };
  };
}
