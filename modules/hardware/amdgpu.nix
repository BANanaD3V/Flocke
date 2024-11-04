{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.nixos.amdgpu.enable {
    environment.systemPackages = with pkgs; [lact];
    systemd.packages = with pkgs; [lact];
    systemd.services.lactd.wantedBy = ["multi-user.target"];
    programs.corectrl = {
      enable = true;
      gpuOverclock.enable = true;
    };
    boot = {
      initrd = {
        kernelModules = ["amdgpu" "dm-snapshot"];
      };
    };
    hardware = {
      graphics = {
        extraPackages = with pkgs; [
          amdvlk
          vaapiVdpau
          libvdpau-va-gl
          rocmPackages.clr.icd
        ];

        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk
        ];
      };
    };
  };
}
