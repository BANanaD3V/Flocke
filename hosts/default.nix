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
    pkgsUnstable = import
    inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgsStable = import
    inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs =
      if host == "server"
      then pkgsStable #pkgsStable TODO: BROKEN
      else pkgsUnstable;
    extraSpecialArgs = {
      inherit inputs host isNixOS username useremail pkgsStable pkgsUnstable pkgs;
    };

    homeManagerImports = [
      ./${host}/home.nix # host specific home-manager configuration
      ../home
      ../options/home
      inputs.schizofox.homeManagerModule
      inputs.nix-colors.homeManagerModules.default
      inputs.prism.homeModules.prism
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
        inherit extraSpecialArgs pkgs;

        modules = homeManagerImports;
      };
in
  builtins.listToAttrs (map (host: {
    name = "${username}-${host}";
    value = mkHost host;
  }) ["pc" "laptop" "server"])
