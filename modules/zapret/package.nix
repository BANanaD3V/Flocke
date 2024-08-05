{
  qnum,
  wan,
  ...
}: {
  config,
  pkgs,
  ...
}: {
  networking = {
    firewall = {
      extraCommands = ''
        iptables -t mangle -I POSTROUTING -o "${wan}" -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num ${toString qnum} --queue-bypass
      '';
    };
  };
  systemd = {
    services = {
      zapret = {
        description = "DPI Bypass";
        wantedBy = ["multi-user.target"];
        requires = ["network.target"];
        serviceConfig = {
          ExecStart = "${pkgs.zapret}/bin/nfqws --pidfile=/run/nfqws.pid --dpi-desync=disorder --dpi-desync-ttl=1 --dpi-desync-split-pos=3 --qnum=${toString qnum}";
          Type = "forking";
          PIDFile = "/run/nfqws.pid";
          ExecReload = "/bin/kill -HUP $MAINPID";
          Restart = "always";
          RestartSec = "5s";
        };
      };
    };
  };
}
