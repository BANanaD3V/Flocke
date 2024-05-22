{
  lib,
  config,
  ...
}: {
  options.server.homepage.enable = lib.mkEnableOption "Enable homepage" // {default = config.server.enable;};
  config = lib.mkIf config.server.homepage.enable {
    services.homepage-dashboard = {
      enable = true;
      listenPort = 3000;
      services = [
        {
          General = [
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
          System = [
            {
              "System info" = {
                href = "http://192.168.1.12:61208/";
                widget = {
                  type = "glances";
                  url = "http://192.168.1.12:61208/";
                  metric = "info";
                };
              };
            }
            {
              "CPU Usage" = {
                href = "http://192.168.1.12:61208/";
                widget = {
                  type = "glances";
                  url = "http://192.168.1.12:61208/";
                  metric = "cpu";
                };
              };
            }
            {
              "Memory Usage" = {
                href = "http://192.168.1.12:61208/";
                widget = {
                  type = "glances";
                  url = "http://192.168.1.12:61208/";
                  metric = "memory";
                };
              };
            }
            {
              "Top Processes" = {
                href = "http://192.168.1.12:61208/";
                widget = {
                  type = "glances";
                  url = "http://192.168.1.12:61208/";
                  metric = "process";
                };
              };
            }
          ];
        }
        {
          Management = [
            {
              Scrutiny = {
                href = "http://192.168.1.12:8083";
                description = "Drive health monitoring";
                widget = {
                  type = "scrutiny";
                  url = "http://192.168.1.12:8083";
                };
              };
            }
            {
              Portainer = {
                href = "https://192.168.1.12:9443";
                ping = "https://192.168.1.12:9443";
                description = "Container management";
                widget = {
                  type = "portainer";
                  env = 2;
                  key = "ptr_LZlIJ+qdf7RKs5cnHPxe8iaOgSVOx+arA8Dy7A+ub+A=";
                  url = "https://192.168.1.12:9443";
                };
              };
            }
            {
              Glances = {
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
                href = "http://192.168.1.12:8200";
                ping = "http://192.168.1.12:8200";
                description = "Web based file browser";
              };
            }
            {
              Jellyfin = {
                href = "http://192.168.1.12:8096/web/index.html";
                description = "A media server";
                widget = {
                  type = "jellyfin";
                  url = "http://192.168.1.12:8096";
                  key = "70874b6f74c2410bb7998aee4f63b995";
                };
              };
            }
          ];
        }
        {
          Games = [
            {
              Pufferpanel = {
                href = "http://192.168.1.12:8090/";
                ping = "http://192.168.1.12:8090/";
                description = "Hosting panel";
              };
            }
            {
              Bluemap = {
                href = "http://192.168.1.12:8100/";
                ping = "http://192.168.1.12:8100/";
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
        background = "https://raw.githubusercontent.com/BANanaD3V/nixos-config/master/home/desktop/hyprland/wallpapers/paintings.png";
        headerStyle = "clean";
        target = "_self";
        backgroundOpacity = 0.17;
        title = "Startpage";
        theme = "dark";
        color = "slate";
        layout = {
          General = {
            style = "row";
            columns = 3;
          };
          System = {
            style = "row";
            columns = 4;
          };
        };
      };
      widgets = [
        {
          glances = {
            url = "http://192.168.1.12:61208";
            cpu = true;
            cputemp = true;
            memory = true;
          };
        }
        {
          resources = {
            disk = ["/" "/run/media/hdd"];
          };
        }
        {
          search = {
            provider = ["custom" "google"];
            url = "http://192.168.1.12:7666/search?q=";
            focus = true;
            target = "_self";
          };
        }
      ];
    };
  };
}
