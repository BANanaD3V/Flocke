{config, ...}:
with config.colorScheme.palette; ''
    * {
        font-family: JetBrainsMono Nerd Font Mono;
        font-size: 13px;
        border-radius: 0px;
    }

    #waybar {
        background-color: #${base00};
        border-radius: 0px;
        transition-property: background-color;
        transition-duration: .5s;
    }

    button {
        border: none;
    }

    button:hover {
        background: inherit;
    }

    #workspaces {
        border-radius: 5px;
        padding-left: 7px;
        padding-right: 7px;
    }

    #workspaces button {
        color: #${base0B};
        padding: 5px;
    }

    #workspaces button.empty {
        color: #${base05};
    }

    #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
    }

    #workspaces button.active {
        color: #${base0A};
    }

    #workspaces button.urgent {
        color: #${base08};
    }

    .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
    }

    .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
    }

    #clock,
    #group-power,
    #backlight,
    #battery,
    #network,
    #memory,
    #group-audio,
    #custom-media,
    #language,
    #privacy,
    #tray,
    #cpu,
    #custom-wl-gammarelay-temperature,
    #custom-cava {
        padding: 0 2px;
        border-radius: 5px;
        color: #${base05};
        padding: 2px;
        margin-top: 8px;
        margin-bottom: 8px;
        padding-left: 6px;
        padding-right: 6px;
    }


    #tray menu menuitem {
        color: #${base02};
    }

    #clock {
        padding-left: 20px;
        color: #${base0A};
    }

    #group-audio {
        padding-right: 20px;
        color: #${base0A};
    }
    #network.disconnected {
        background-color: #${base08};
    }

    #battery.critical:not(.charging) {
        background-color: #${base08};
    }

    #pulseaudio, #pulseaudio-slider {
        color: #${base0A};
        border-radius: 5px;
    }

    #pulseaudio-slider {
        margin-left: 10px;
        padding: 0;
        min-width: 100px;
    }

    slider {
        margin: 0;
        padding: 0;
        min-height: 0px;
        min-width: 0px;
        border-radius: 5px;
        box-shadow: none;
    }

  #pulseaudio-slider trough {
      min-width: 8px;
      min-height: 4px;
      border-radius: 5px;
      background-color: #${base02};
  }

  #pulseaudio-slider highlight {
      min-width: 8px;
      border-radius: 5px;
      background-color: #${base0A};
  }

    #custom-reboot,
    #custom-lock,
    #custom-quit {
        color: #${base05};
        margin-left: 5px;
        margin-right: 5px;
        padding: 2px;
    }
    #custom-reboot:hover,
    #custom-lock:hover,
    #custom-quit:hover {
        color: #${base0A};
    }

    #custom-media {
        margin-right: 0px;
        padding: 2px;
    }
    #custom-power {
        color: #${base08};
        margin-left: 5px;
        margin-right: 5px;
        padding: 2px;
    }

    #group-power {
        padding: 2px;
        padding-left: 10px;
        padding-right: 10px;
        margin-right: 10px;
    }

    #custom-media {
        min-width: 100px;
        margin-right: 0px;
    }
''
