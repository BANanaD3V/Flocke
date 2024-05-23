{
  inputs,
  isNixOS,
  lib,
  system,
  username,
  ...
}: let
  mkHost = host: let
    pkgs = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    extraSpecialArgs = {
      inherit inputs host isNixOS username;
    };

    homeManagerImports = [
      ./${host}/home.nix # host specific home-manager configuration
      ../home
      ../options/home
      inputs.schizofox.homeManagerModule
      inputs.nix-colors.homeManagerModules.default
      inputs.prism.homeModules.prism
      # inputs.nixvim.homeManagerModules.nixvim
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
          inputs.nur.nixosModules.nur
          inputs.home-manager.nixosModules.home-manager
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.sops-nix.nixosModules.sops
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

        pkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
        };
        modules = homeManagerImports;
      };
in
  builtins.listToAttrs (map (host: {
    name = "${username}-${host}";
    value = mkHost host;
  }) ["pc" "laptop" "server"])
