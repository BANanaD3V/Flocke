{...}: {
  services = {
    byedpi = {
      enable = true;
      openFirewall = true;
      address = "127.0.0.1";
      socksPort = 1081;
      commandLine = ''
        --split 1 --oob 1 mod-http=h,d --auto none --fake -1 --tlsrec 3+h
      '';
    };
  };
}
