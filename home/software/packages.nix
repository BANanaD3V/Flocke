{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Archives
    zip
    xz
    unzip
    p7zip

    # CLI Utils
    ripgrep
    jq
    eza
    fzf
    bat
    cava
    feh
    # thefuck
    unrar
    openvpn
    ffmpeg-full
    appimage-run

    # Desktop stuff
    mpd
    mpdevil

    ncmpcpp
    mpc-cli
    freetube
    flatpak
    # calcure
    qbittorrent
    kdenlive
    krita
    gimp
    gnome.nautilus
    gnome.gnome-boxes
    kvmtool
    hyprpaper
    inputs.nixpkgs-wayland.packages.${pkgs.system}.swww
    wl-clipboard
    cliphist
    keepass
    keepassxc
    keepass-diff
    wl-clip-persist
    hyprpicker
    imagemagick
    grim
    inputs.nixpkgs-wayland.packages.${system}.slurp
    libreoffice
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
    (signal-desktop-beta.overrideAttrs {
      desktopItems = [
        (makeDesktopItem {
          name = "signal";
          desktopName = "Signal";
          exec = "signal-desktop-beta --disable-gpu %U";
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
    libreoffice
    zathura
    todoist-electron
    obsidian

    # Development
    cargo
    rustfmt
    rustc
    # dotnetCorePackages.sdk_8_0_2xx
    # dotnet-sdk_8
    texliveFull
    commitizen
    python3
    # insomnia
    godot_4
    nodejs_20
    bun
    nodePackages.pnpm
    yarn
    # gcc
    # libstdcxx5
    # zlib
    # gnumake
    gh
    icu74
    jdk17
    filezilla
    docker
    docker-compose
    distrobox
    # libglibutil
    # glib
    # glibc
    # figma-linux
    direnv
    vscode
    jetbrains.idea-community
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
    # blender
    # cura
    flashprint

    # Gaming
    r2modman
    bottles
    steamcmd
    heroic
    gamemode
    lutris
    mangohud
    gamescope
    prismlauncher
    blockbench
    # inputs.getchoo.packages.${pkgs.system}.modrinth-app
    wine-staging
    winetricks
    # inputs.game-rs.packages.x86_64-linux.default
    # inputs.nix-gaming.packages.${pkgs.system}.star-citizen

    # Sound
    pipewire
    # soundux
    lyrebird
    wireplumber
    alsaLib
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
