{lib, ...}: {
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    port = 8432;
    ensureUsers = [
      {
        name = "mentalitet";
        ensureDBOwnership = true;
      }
      {
        name = "journix";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [
      "mentalitet"
      "journix"
    ];
    authentication = lib.mkOverride 10 ''
      local all all              trust
      host  all all 127.0.0.1/32 trust
      host  all all ::1/128      trust
    '';
  };
}
