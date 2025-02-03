{
  inputs,
  isNixOS,
  lib,
  system,
  username,
  useremail,
  ...
}: let
  mkHost = host: let
    pkgsStable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    pkgsMaster = import inputs.nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };

    extraSpecialArgs = {
      inherit inputs host isNixOS username useremail pkgsStable pkgsMaster;
    };

    homeManagerImports = [
      ./${host}/home.nix # host specific home-manager configuration
      ../home
      ../options/home
      inputs.schizofox.homeManagerModule
      inputs.nix-colors.homeManagerModules.default
    ];
  in
    if isNixOS
    then
      lib.nixosSystem {
        specialArgs = extraSpecialArgs;

        modules = [
          ./${host} # host specific configuration
          ./${host}/hardware-configuration.nix # host specific hardware configuration
          ../modules
          ../pkgs
          ../options/nixos
          inputs.home-manager.nixosModules.home-manager
          inputs.zapret.nixosModules.zapret
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          inputs.chaotic.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "back";

              inherit extraSpecialArgs;

              users.${username} = {
                imports = homeManagerImports;
                programs.home-manager.enable = true;
              };
            };
          }
          # alias for home-manager
          (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
        ];
      }
    else
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;

        modules = homeManagerImports;
      };
in
  builtins.listToAttrs (map (host: {
    name = "${host}";
    value = mkHost host;
  }) ["pc" "laptop" "server"])
