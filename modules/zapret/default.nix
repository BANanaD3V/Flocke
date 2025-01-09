{pkgs, ...}: {
  imports = [
    ./package.nix
  ];
  services.zapret = {
    enable = true;
    package = pkgs.zapret;
    params = [
      # "--dpi-desync=fake,disorder2"
      "--dpi-desync-repeats=15"
      "--dpi-desync-tll=0"
      "--dpi-desync-tll6=0"
      "--dpi-desync=fake,split"
      "--wssize 1:6"
      "--dpi-desync-fooling=md5sig,badseq"
      "--new"
      "--filter-udp=50000-65535"
      "--dpi-desync=fake"
      "--dpi-desync-any-protocol"
      "--dpi-desync-cutoff=d4 "
      # "-dpi-desync-fake-tls=${./tls_clienthello_www_google_com.bin}"
    ];
    whitelist = [
      "youtube.com"
      "googlevideo.com"
      "ytimg.com"
      "youtu.be"
      "rutracker.org"
      "rutracker.cc"
      "rutrk.org"
      "t-ru.org"
      "medium.com"
      "quora.com"
      "quoracdn.net"
      "1e100.net"
      "doubleclick.net"
      "gmailpostmastertools.googleapis.com"
      "googleusercontent.com"
      "googlevideo.com"
      "gstatic.com"
      "gvt1.com"
      "i9.ytimg.com"
      "i.ytimg.com"
      "l.google.com"
      "mtalk.google.com"
      "nhacmp3youtube.com"
      "NS1.google.com"
      "NS2.google.com"
      "NS3.google.com"
      "NS4.google.com"
      "play.google.com"
      "video.google.com"
      "youtu.be"
      "youtube.com"
      "youtubeeducation.com"
      "youtube.googleapis.com"
      "youtubei.googleapis.com"
      "youtubekids.com"
      "youtube-nocookie.com"
      "yt3.ggpht.com"
      "yt4.ggpht.com"
      "yt.be"
    ]; # blacklist = [ ];
    # qnum = 200;
    configureFirewall = true;
    # httpSupport = true;
  };
}
