{inputs, ...}: {
  services.zapret.enable = true;
  services.zapret.config = ''
        FWTYPE=nftables
        MODE=nfqws
        MODE_HTTP=0
        MODE_HTTP_KEEPALIVE=0
        MODE_HTTPS=1
        MODE_QUIC=1
     QUIC_PORTS=50000-65535
    MODE_FILTER=hostlist
    NFQWS_OPT_DESYNC="--dpi-desync-repeats=10 --dpi-desync=syndata --dpi-desync-fooling=md5sig"
    TPWS_OPT="--dpi-desync-repeats=45 --dpi-desync=syndata,fake,split2 --dpi-desync-fooling=md5sig"
    NFQWS_OPT_DESYNC_QUIC="--dpi-desync=fake,tamper --dpi-desync-any-protocol"
        INIT_APPLY_FW=1
        DISABLE_IPV6=0
  '';
}
