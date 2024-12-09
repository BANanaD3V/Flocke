{
  pkgs,
  host,
  lib,
  config,
  username,
  ...
}: let
  wallpaper = "/home/${username}/.config/wallpapers/${config.home-manager.wallpaper}";
in {
  config = lib.mkIf config.home-manager.graphical.enable {
    xdg.configFile."hypr/hyprlock.conf".text = with config.colorScheme.palette; ''
                 background {
                     monitor =
                     path = ${wallpaper}

                     # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
                     blur_passes = 2 # 0 disables blurring
                     blur_size = 7
                     noise = 0.0117
                     contrast = 0.8916
                     brightness = 0.8172
                     vibrancy = 0.1696
                     vibrancy_darkness = 0.0
                 }

      input-field {
          monitor =
          size = 250, 50
          outline_thickness = 3
          dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.64 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgb(${base00})
          inner_color = rgb(${base01})
          font_color = rgb(${base05})
          fade_on_empty = true
          placeholder_text = <i>Password...</i> # Text rendered in the input box when it's empty.
          hide_input = false
          position = 0, 50
          halign = center
          valign = bottom
      }

      # Current time
      label {
          monitor =
          text = cmd[update:1000] echo "<b><big> $(date +"%I:%M %p") </big></b>"
          color = rgb(${base05})
          font_size = 64
          font_family = JetBrains Mono Nerd Font 10
          position = 0, 160
          halign = center
          valign = top
      }



      # Type to unlock
      # label {
      #     monitor =
      #     text = Type to unlock!
      #     color = $color0
      #     font_size = 16
      #     font_family = JetBrains Mono Nerd Font 10
      #     position = 0, 30
      #     halign = center
      #     valign = bottom
      # }
    '';

    home.packages = with pkgs; [
      hyprlock
    ];
  };
}
