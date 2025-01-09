{
  pkgs,
  username,
  ...
}: {
  fonts.packages = [
    (pkgs.callPackage ./illinois-mono.nix {})
  ];
  users.users.${username}.packages = with pkgs; [
  ];

  environment.systemPackages = [
    pkgs.gnome-boxes

    (pkgs.libsForQt5.callPackage ./tokyo-night-sddm.nix {})
  ];
}
