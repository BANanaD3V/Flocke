{
  pkgs,
  username,
  ...
}: {
  users.users.${username}.packages = with pkgs; [
    # (pkgs.callPackage ./soundux.nix {})
  ];

  environment.systemPackages = [
    (pkgs.libsForQt5.callPackage ./tokyo-night-sddm.nix {})
  ];
}
