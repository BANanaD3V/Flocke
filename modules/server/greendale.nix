{
  inputs,
  config,
  lib,
  ...
}: {
  #options.server.greendale.enable = lib.mkEnableOption "Enable greendale network" // {default = config.server.enable;};
  imports = [
    #inputs.greendale.nixosModules.default
  ];
  #config = lib.mkIf config.server.greendale.enable {
  #  services.greendale = {
  #    enable = true;
  #  };
  #};
}
