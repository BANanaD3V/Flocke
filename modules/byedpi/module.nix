{...}: {
  services = {
    byedpi = {
      enable = true;
      openFirewall = true;
      address = "127.0.0.1";
      socksPort = 1081;
      commandLine = ''
        -s1 -q1 -f-1 -S -b1000 -As
      '';
    };
  };
}
