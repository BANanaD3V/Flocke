{...}: {
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
