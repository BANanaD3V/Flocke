{...}: {
  wayland.windowManager.hyprland = {
    # settings.env = [
    #   "WLR_DRM_DEVICES,/home/banana/.config/hypr/card"
    # ];
  };

  home-manager = {
    colorscheme = "catppuccin";
    graphical.enable = true;
    displays = {
      main = "eDP-1";
      displays = [
        {
          name = "eDP-1";
          hyprland = "1920x1080@144,0x0,1.15";
          workspaces = [1 2 3 4 5 6 7 8 9 10];
        }
      ];
    };
    hyprland.enable = true;
    lid.enable = true;
    touchpad.enable = true;
    battery.enable = true;
    backlight.enable = true;
    gaming.enable = true;
  };
}
