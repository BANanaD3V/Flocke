{inputs, ...}: {
  imports = [inputs.nixos-hardware.nixosModules.common-gpu-nvidia-disable];
  services.logind.powerKey = "ignore";
  server.enable = false;
  nixos = {
    nvidia = {
      drivers = {
        enable = true;
        version = "beta";
      };
      hyprland.enable = false;
    };
  };
}
