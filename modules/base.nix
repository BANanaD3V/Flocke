{
  lib,
  host,
  pkgs,
  config,
  inputs,
  system,
  username,
  ...
}: {
  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "networkmanager" "adbusers"];
    shell = pkgs.zsh;
  };

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.kernelModules = ["v4l2loopback"];
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.loader.grub = {
    enable = lib.mkForce true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    # theme = inputs.catppuccin-grub + "/src/catppuccin-mocha-grub-theme";
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  # boot.kernel.sysctl = {
  #   "vm.max_map_count" = 1048576;
  # };

  # Kernel for star citizen
  boot.kernel.sysctl = lib.mkIf config.hm.home-manager.gaming.star-citizen.enable {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  # Fix USB sticks not mounting or being listed:
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Bash shebang
  services.envfs.enable = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
  services.tailscale.enable = true;
  # Hardware
  hardware.graphics.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Adb
  programs.adb.enable = true;

  # Networking
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    firewall.enable = false;
    extraHosts = lib.mkIf config.hm.home-manager.gaming.star-citizen.enable "127.0.0.1 modules-cdn.eac-prod.on.epicgames.com";
  };
  services.blueman.enable = config.hm.home-manager.bluetooth.enable;
  systemd.services.NetworkManager-wait-online.enable = false;
  # XDG Desktop Portal stuff
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    config.common.default = "*";
  };

  # X server
  services.xserver = {
    enable = config.hm.home-manager.graphical.enable;
    excludePackages = with pkgs; [xterm];
  };
  services.displayManager.sddm = {
    enable = lib.mkForce config.hm.home-manager.graphical.enable;
    wayland.enable = true;
    sugarCandyNix = {
      enable = true; # This enables SDDM automatically and set its theme to
      # "sddm-sugar-candy-nix"
      settings = with config.hm.colorScheme.palette; {
        # Set your configuration options here.
        # Here is a simple example:
        Background = lib.cleanSource ../home/desktop/hyprland/wallpapers/${config.hm.home-manager.wallpaper};
        FormPosition = "right";
        HaveFormBackground = true;
        PartialBlur = true;
        OverrideLoginButtonTextColor = "#${base05}";
        MainColor = "#${base05}";
        AccentColor = "#${base07}";
        BackgroundColor = "#${base00}";
        # ...
      };
    };
  };

  # Printing support
  services.printing = {
    enable = true;
    drivers = [pkgs.epson-escpr];
  };

  # Flatpak
  services.flatpak.enable = true;

  # Sound
  security.rtkit.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true; # (optional)
  };
  programs.noisetorch.enable = true;

  # Locate
  services.locate = {
    enable = true;
  };

  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  # Locale
  time.timeZone = "Europe/Moscow";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Env packages
  environment.systemPackages = with pkgs; [
    nh
    virt-manager
    gnome.gnome-disk-utility
    gutenprint
    git
    btrfs-progs
    btrfs-snap
    curl
    wget
    jq
    polkit
    polkit_gnome
  ];

  environment.sessionVariables = {
    FLAKE = "/home/${username}/nixos-config";
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "DroidSansMono"];})
    font-awesome
    manrope
    inter
    lexend
    material-design-icons
    meslo-lg
    meslo-lgs-nf
  ];

  # Virtualization
  virtualisation.libvirtd.enable = true;
  virtualisation.waydroid.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # Enable needed programs
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh.enable = true;
  };
  # Nixos docs
  documentation = {
    nixos.enable = false;
    info.enable = false;
    man.enable = false;
  };
  # System stateversion
  system.stateVersion = "23.05";
}
