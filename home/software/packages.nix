{
  pkgs,
  pkgsMaster,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Archives
    libsecret
    zip
    xz
    unzip
    p7zip

    # CLI Utils
    ripgrep
    jq
    eza
    zoxide
    fzf
    bat
    # cava
    feh
    # thefuck
    unrar
    openvpn
    sshuttle
    ffmpeg-full
    appimage-run

    # Desktop stuff
    mpd
    mpdevil
    feishin
    ncmpcpp
    mpc-cli
    freetube
    flatpak
    # calcure
    qbittorrent
    kdenlive
    krita
    gimp
    nautilus
    kvmtool
    hyprpaper
    inputs.nixpkgs-wayland.packages.${pkgs.system}.swww
    wl-clipboard
    cliphist
    keepassxc
    keepass-diff
    wl-clip-persist
    hyprpicker
    imagemagick
    grim
    inputs.nixpkgs-wayland.packages.${system}.slurp
    ydotool
    lutgen

    # Gui apps
    # authy
    firefox
    tor-browser
    gnumake
    # firefox-devedition-bin-unwrapped
    chromium
    element-desktop
    # signal-desktop
    (signal-desktop.overrideAttrs {
      # postFixup = ''
      #   wrapProgram $out/bin/signal-desktop-beta \
      #     --run 'export HTTP_PROXY=socks://127.0.0.1:1081 HTTPS_PROXY=socks://127.0.0.1:1081'
      # '';
      desktopItems = [
        (makeDesktopItem {
          name = "signal";
          desktopName = "Signal";
          exec = "signal-desktop --disable-gpu %U";
          icon = "signal";
          startupWMClass = "Signal Beta";
          genericName = "Internet Messenger";
          keywords = ["call" "signal" "electron" "chat"];
          categories = ["Network" "InstantMessaging" "Chat"];
        })
      ];
    })
    # cinny-desktop
    telegram-desktop
    zoom-us
    qdirstat
    mpv
    libreoffice-still
    zathura
    obsidian
    nicotine-plus
    # beets
    (streamrip.overrideAttrs
      (old: {
        src = fetchFromGitHub {
          owner = "mortalis13";
          repo = "streamrip";
          rev = "3ebbdad19362d942af47e71562eda1416a1816c7";
          sha256 = "sha256-Zh8VDlTrLEHMNK/5KEDcXV34dgofsmC9nnFw/AVRJKA=";
        };
      }))

    # Development
    cargo
    rustfmt
    rustc
    # dotnetCorePackages.sdk_8_0_3xx-bin
    dotnet-sdk
    commitizen
    python3
    go
    # insomnia
    godot_4
    nodejs_23
    bun
    nodePackages.pnpm
    yarn
    # gcc
    # libstdcxx5
    # zlib
    # gnumake
    gh
    tea
    git-credential-oauth
    icu74
    jdk17
    filezilla
    docker
    docker-compose
    distrobox
    # libglibutil
    glib
    libunwind
    glibc
    # figma-linux
    vscode
    # jetbrains.idea-community
    android-studio
    # (pkgs.vscode.overrideAttrs (o: let
    #   version = "1.81.1";
    #   plat = "linux-x64";
    # in {
    #   src = pkgs.fetchurl {
    #     name = "VSCode_${version}_${plat}.tar.gz";
    #     url = "https://update.code.visualstudio.com/${version}/${plat}/stable";
    #     sha256 = "sha256-Tqawqu0iR0An3CZ4x3RGG0vD3x/PvQyRhVThc6SvdEg=";
    #   };
    # }))
    yt-dlp
    vlc
    alejandra
    pciutils
    # ngrok

    # 3D modeling and printing
    blender
    # cura
    # flashprint

    # Gaming
    r2modman
    (tetrio-desktop.overrideAttrs (old: {
      withTetrioPlus = true;
    }))
    steamcmd
    heroic
    lutris
    mangohud
    gamescope
    prismlauncher
    # (prismlauncher.override {withWaylandGLFW = true;})
    blockbench
    # inputs.getchoo.packages.${pkgs.system}.modrinth-app
    wineWowPackages.stable
    winetricks
    # inputs.game-rs.packages.x86_64-linux.default
    # (inputs.nix-gaming.packages.${pkgs.system}.star-citizen.override {
    #   gameScopeEnable = true;
    #   gameScopeArgs = [
    #     "-W 3440"
    #     "-H 1440"
    #     "-b"
    #   ];
    # })

    # Sound
    pipewire
    # soundux
    lyrebird
    wireplumber
    alsa-lib
    pamixer
    playerctl
    wev
    pavucontrol

    # QT
    qt5.qtwayland
    qt6.qtwayland
    qt6.qmake
  ];
}
