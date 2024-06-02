{
  pkgs,
  username,
  ...
}: {
  users.users.${username}.packages = with pkgs; [
    (pkgs.callPackage ./insomnia.nix {})
  ];
  environment.systemPackages = [
    (pkgs.libsForQt5.callPackage ./tokyo-night-sddm.nix {})
  ];
}
