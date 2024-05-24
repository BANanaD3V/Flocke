{...}: {
  server.enable = false;
  nixos = {
    nvidia = {
      drivers = {
        enable = true;
        version = "production";
      };
      hyprland.enable = false;
    };
  };
}
