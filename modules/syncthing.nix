{
  config,
  lib,
  ...
}: {
  options.syncthing.enable = lib.mkEnableOption "Enable syncthing" // {default = true;};
  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
    };
  };
}
