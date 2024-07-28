{...}: {
  services = {
    byedpi = {
      enable = true;
      openFirewall = true;
      address = "127.0.0.1";
      socksPort = 1081;
      commandLine = ''
        --disorder 3 --auto=torst --tlsrec 1+s
      '';
    };
  };
}
