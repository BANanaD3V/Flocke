{...}: {
  # Main drive
  #
  fileSystems."/run/media/hdd" = {
    device = "/dev/disk/by-label/1tb_hdd";
    fsType = "ext4";
  };
  #
  # fileSystems."/run/media/hdd" = {
  #   device = "/dev/disk/by-label/1tb_hdd";
  #   fsType = "btrfs";
  # };
  #
  nixos = {};
  server.jellyfin.enable = false;
  server."0x0".enable = false;

  users.users.banana.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDR1Yv50adoFU3kvrKqJtlr0EO6oeIDsMu9TqP3dFtJW5SFEKKvuNlHidQSGcFo1ALv4UxhggucTWGd5/bfVWdcZNa8vv6jHtqDxMhINQWgp7IE9eXzyja+fRII35f2NJaCV4mAHUuEj2F7Eqj66Vwi/7h8BAqXdgTjxQV3htytKaJz90ZpthbdYFJtT8azErcDUW9P4Mkyt6YiZOfyD8O5w/uRx1IPqAxcUE2XnYBFK6EKUCSWF8G/4h6A2mVJGrgd5P+shCrovmlFRpgE6jZC9T+q91hq10rDL9CdMc1+n/4LHMR0BRfjCayeuQOvo1zcZrsdwjoJEy2Mf70LDgnVNkqJn7PIe0TnE9KPZ2KaeV9m0+Ifs1UmbhLndtnbRD69bS0H64ISXuqWtwlDts9Cc52XDdZisCpR7WAEFE/Fuy/47fISxi1Xfs9SHhcb6VZtcvLSgKCOdVJXck2SUP0UhV2LjMnPIjR6zhPZe299zQhxKfXgLGMRQjmPQB7WOcUK35rgxx75zWZGvhhFU/rOU3x4JhZFWniwQhZ7HTbzFtBxYJCT34BGFv9Ku6Qe8ZLK/aYzJCEGNhrRuU6x9bBGGu3T7t5ifHv6Rh2OmbksMuv6W0OO8LPPDIvYR/9CVxcqIYMEK4xgaPMRtqbI25R0CsQN/d/gRz04QGBMy0h5jw=="
  ];
}
