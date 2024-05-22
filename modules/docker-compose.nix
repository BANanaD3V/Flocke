{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.docker-compose;
  settingsFormat = pkgs.formats.yaml {};
  composeFile = name: service:
    if service.composeContents != {}
    then settingsFormat.generate "${name}-docker-compose" service.composeContents
    else service.composeFile;
in {
  options = {
    services.docker-compose = {
      enable =
        mkEnableOption
        (mdDoc "Set up docker-compose.yml files in /var/lib");

      services = mkOption {
        default = {};
        description = mdDoc ''
          each service copies its docker-compose.yml into /var/lib/{name}
        '';
        type = types.attrsOf (types.submodule ({name, ...}: {
          options = {
            name = mkOption {
              type = types.str;
              default = name;
              description = ''
                goes in /var/lib/{name}
              '';
            };

            composeContents = mkOption {
              type = settingsFormat.type;
              default = {};
              description = lib.mdDoc ''
                docker-compose.yml contents as nix attr set.
              '';
            };

            composeFile = lib.mkOption {
              type = lib.types.nullOr lib.types.path;
              default = null;
              description = lib.mdDoc ''
                compose file, instead of specifying compose contents
              '';
            };

            environmentFile = lib.mkOption {
              type = lib.types.nullOr lib.types.path;
              default = null;
              description = lib.mdDoc ''
                File containing environment variables to be used for substitution in
                the resulting docker-compose file; a path containing text `VAR=VALUE`
                will result in `$VAR` be replaced with `VALUE`.
              '';
            };

            additionalFiles = lib.mkOption {
              type = with lib.types; listOf path;
              default = [];
              description = lib.mdDoc ''
                Additional file paths to copy into service directory
              '';
            };

            systemd-service = {
              enable =
                mkEnableOption
                (mdDoc "Set up systemd service to run docker-compose");
              user = lib.mkOption {
                type = lib.types.str;
                default = "root";
                description = lib.mdDoc ''
                  user to run as -- if root, cannot be docker rootless. uid must be set
                  explicitly
                '';
              };
              serviceDependencies = lib.mkOption {
                type = with lib.types; listOf str;
                default = ["docker.service"];
                description = lib.mdDoc ''
                  List of Systemd services to require and wait for starting
                  docker-compose, if overriden, should include `docker.service`
                '';
              };
              preStartAdditionalLines = mkOption {
                type = types.str;
                default = "";
                description = ''
                  Additional lines at the end of PreStart, for moving files, fixing
                  permissions, etc.
                '';
              };
            };
          };
        }));
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion =
          (builtins.any
            (service: service.systemd-service.enable) (builtins.attrValues cfg.services))
          -> (config.virtualisation.docker.enable || config.virtualisation.docker.rootless.enable);

        message = ''
          Docker virtualisation backend must be enabled by `config.virtualisation.docker.enable = true;` or `config.virtualisation.docker.rootless.enable = true;`
        '';
      }
      {
        assertion =
          builtins.all
          (service: !((service.composeContents != {}) && (service.composeFile != null))) (builtins.attrValues cfg.services);
        message = ''
          Only one of `composeContents` and `composeFile` can be set.
        '';
      }
    ];

    systemd.services =
      mapAttrs'
      (name: value:
        nameValuePair "generate-docker-compose-${name}" {
          description = "Generate docker-compose for service ${name}";
          wantedBy = [
            "multi-user.target"
          ];
          partOf = [
            "docker.service"
          ];
          after = value.systemd-service.serviceDependencies;
          preStart =
            ''
              dataDir=/var/lib/${name}
              mkdir -p $dataDir
              test -f $dataDir/docker-compose.yml && rm $dataDir/docker-compose.yml
            ''
            + lib.optionalString (value.environmentFile != null) ''
              set -o allexport
              source ${value.environmentFile}
              set +o allexport
            ''
            + ''
              ${pkgs.envsubst}/bin/envsubst \
                -i ${composeFile name value} \
                -o ''${dataDir}/docker-compose.yml
            ''
            + lib.concatMapStringsSep "\n" (x: ''
              file=''${dataDir}/${builtins.baseNameOf x}
              test -f $file && rm $file
              ${pkgs.envsubst}/bin/envsubst \
                -i ${x} \
                -o $file
              chown ${value.systemd-service.user}:${config.users.users.${value.systemd-service.user}.group} $file
            '')
            value.additionalFiles
            + ''
              chown ${value.systemd-service.user}:${config.users.users.${value.systemd-service.user}.group} $dataDir ''${dataDir}/docker-compose.yml

            ''
            + value.systemd-service.preStartAdditionalLines;
          serviceConfig = {
            Type = "oneshot";
            User = "root";
            RemainAfterExit = "yes";
            # WorkingDirectory = "/var/lib/${name}";
            ExecStart = pkgs.writeShellScript "run-docker-compose-${name}" ''
              dataDir=/var/lib/${name}
              cd $dataDir
              ${
                if value.systemd-service.enable
                then "${optionalString (value.systemd-service.user != "root") "${pkgs.sudo}/bin/sudo -u ${value.systemd-service.user} DOCKER_HOST=unix:///run/user/${builtins.toString config.users.users.${value.systemd-service.user}.uid}/docker.sock"} ${pkgs.docker-compose}/bin/docker-compose up -d --remove-orphans"
                else "${pkgs.bash}/bin/bash -c \"echo '########## no service'\""
              }
            '';
          };
        })
      cfg.services;
  };
}
