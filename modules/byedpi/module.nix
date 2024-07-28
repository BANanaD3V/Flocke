{...}: {
  services = {
    byedpi = {
      enable = true;
      openFirewall = true;
      address = "127.0.0.1";
      socksPort = 1081;
      commandLine = ''
        --disorder 3 --oob 1+sni --split -1+host --tlsrec 3 --tlsrec +sni
      '';
    };
  };
}
