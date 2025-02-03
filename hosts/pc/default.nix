{username, ...}: {
  # Hyprland and nvidia
  programs.hyprland = {
    enable = true;
  };

  services.displayManager.autoLogin = {
    user = username;
    enable = true;
  };
  services.getty.autologinUser = username;

  server.enable = false;
  # server.greendale.enable = true;
  nixos = {
    amdgpu.enable = true;
    nvidia = {
      drivers = {
        version = "beta";
        enable = false;
      };
      hyprland.enable = false;
    };
    drives = [
      {
        label = "1tb_ssd";
        mountpoint = "/run/media/ssd";
        fstype = "btrfs";
      }
      # {
      #   label = "1tb_hdd";
      #   mountpoint = "/run/media/hdd";
      #   fstype = "btrfs";
      # }
    ];
  };
}
