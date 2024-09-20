{...}: {
  services = {
    byedpi = {
      enable = true;
      openFirewall = true;
      address = "127.0.0.1";
      socksPort = 1081;
      commandLine = ''
        --disorder 1 --split 4
      '';
    };
  };
}
