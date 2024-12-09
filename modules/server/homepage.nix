{
  lib,
  config,
  pkgsStable,
  ...
}: {
  options.server.homepage.enable = lib.mkEnableOption "Enable homepage" // {default = config.server.enable;};
  config = lib.mkIf config.server.homepage.enable {
    services.homepage-dashboard = {
      enable = true;
      package = pkgsStable.homepage-dashboard;
      listenPort = 3000;
      services = [
        {
          "2_General" = [
            {
              AdGuard = {
                icon = "adguard-home";
                href = "http://192.168.1.12:8082/";
                description = "DNS-level Ad Blocking";
                widget = {
                  type = "adguard";
                  url = "http://192.168.1.12:8082/";
                };
              };
            }
            {
              Transmission = {
                icon = "transmission";
                href = "http://192.168.1.12:9091/";
                description = "Torrent client";
                widget = {
                  type = "transmission";
                  url = "http://192.168.1.12:9091";
                };
              };
            }
            {
              Speedtest = {
                icon = "librespeed";
                href = "http://192.168.1.12:8765/";
                description = "Network speed test";
                widget = {
                  type = "speedtest";
                  url = "http://192.168.1.12:8765";
                };
              };
            }
          ];
        }
        {
          "1_System" = [
            {
              "System info" = {
                href = "http://192.168.1.12:61208/";
                widget = {
                  type = "glances";
                  url = "http://192.168.1.12:61208/";
                  metric = "info";
                  chart = false;
                };
              };
            }
            {
              "Network" = {
                href = "http://192.168.1.12:61208/";
                widget = {
                  type = "glances";
                  url = "http://192.168.1.12:61208/";
                  metric = "network:enp4s0";
                  chart = false;
                };
              };
            }

            {
              "SSD usage" = {
                href = "http://192.168.1.12:61208/";
                widget = {
                  type = "glances";
                  url = "http://192.168.1.12:61208/";
                  metric = "fs:/";
                  chart = false;
                };
              };
            }
            {
              "HDD usage" = {
                href = "http://192.168.1.12:61208/";
                widget = {
                  type = "glances";
                  url = "http://192.168.1.12:61208/";
                  metric = "fs:/run/media/hdd";
                  chart = false;
                };
              };
            }
          ];
        }
        {
          Management = [
            {
              Scrutiny = {
                icon = "scrutiny";
                href = "http://192.168.1.12:8083";
                description = "Drive health monitoring";
                widget = {
                  type = "scrutiny";
                  url = "http://192.168.1.12:8083";
                };
              };
            }
            {
              Glances = {
                icon = "glances";
                href = "http://192.168.1.12:61208/";
                description = "System monitoring";
              };
            }
          ];
        }
        {
          Storage = [
            {
              Nextcloud = {
                href = "https://nextcloud.banana.is-cool.dev/";
                description = "Data storage";
              };
            }
            {
              "File Browser" = {
                href = "http://192.168.1.12:9999";
                description = "Web based file browser";
              };
            }
            {
              Jellyfin = {
                href = "http://192.168.1.12:8096/web/index.html";
                description = "A media server";
              };
            }
          ];
        }
        {
          Games = [
            {
              Pufferpanel = {
                href = "http://192.168.1.12:8080/";
                description = "Hosting panel";
              };
            }
            {
              Bluemap = {
                href = "http://192.168.1.12:8100/";
                description = "Server 3D map";
              };
            }
          ];
        }
      ];
      settings = {
        providers = {
          openweathermap = "openweathermapapikey";
          weatherapi = "weatherapiapikey";
        };
        background = {
          image = "https://raw.githubusercontent.com/BANanaD3V/Flocke/master/home/desktop/hyprland/wallpapers/paintings.png";
          opacity = 60;
        };
        cardBlur = "md";
        headerStyle = "clean";
        target = "_self";
        title = "Startpage";
        theme = "dark";
        useEqualHeights = true;
        color = "slate";
        layout = {
          "1_System" = {
            style = "row";
            header = false;
            columns = 4;
          };

          "2_General" = {
            style = "row";
            header = false;
            columns = 3;
          };
        };
      };
      widgets = [
        {
          greeting = {
            text_size = "4xl";
            text = "א";
          };
        }
        {
          openmeteo = {
            latitude = "55.755826";
            longitude = "37.6173";
            units = "metric";
            cache = 5;
          };
        }
      ];
    };
  };
}
