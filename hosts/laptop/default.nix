{inputs, ...}: {
  imports = [inputs.nixos-hardware.nixosModules.common-gpu-nvidia-disable];
  services.logind = {
    powerKey = "ignore";
    powerKeyLongPress = "poweroff";
  };
  server.enable = false;
  nixos = {
    nvidia = {
      drivers = {
        enable = false;
        version = "beta";
      };
      hyprland.enable = false;
    };
  };
}
