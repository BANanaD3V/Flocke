{
  inputs,
  config,
  pkgs,
  ...
}: {
  # imports = [
  #   inputs.nix-gaming.nixosModules.steamCompat
  # ];
  hardware.xpadneo.enable = true;
  programs.steam = {
    enable = config.hm.home-manager.gaming.steam.enable;
    # extraCompatPackages = [
    #   inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    # ];
  };
}
