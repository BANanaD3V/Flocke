{...}: {
  server.pufferpanel = {
    enable = true;
    environment = {
      PUFFER_WEB_HOST = ":9005";
    };
  };
}
