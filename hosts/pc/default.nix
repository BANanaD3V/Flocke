{username, ...}: {
  # Hyprland and nvidia
  programs.hyprland = {
    enable = true;
  };

  services.xserver.displayManager.autoLogin = {
    user = username;
    enable = true;
  };
  services.getty.autologinUser = username;

  server.enable = false;
  nixos = {
    nvidia = {
      drivers = {
        version = "beta";
        enable = true;
      };
      hyprland.enable = true;
    };
    drives = [
      {
        label = "1tb_ssd";
        mountpoint = "/run/media/ssd";
        fstype = "btrfs";
      }
      {
        label = "1tb_hdd";
        mountpoint = "/run/media/hdd";
        fstype = "btrfs";
      }
    ];
  };
}
