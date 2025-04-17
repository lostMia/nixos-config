{
  pkgs,
  nur,
  unstable,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    unstable.neovim
    neovide
    vim
    wget
    fish
    firefox-bin
    # unstable.flameshot
    libsForQt5.full
    libsForQt5.qt5.full
    libsForQt5.qt5.qttools
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtbase
    libsForQt5.kguiaddons
    wl-clipboard
    zoxide
    alacritty
    keepassxc
    bash
    waybar
    autotiling
    signal-desktop
    electron_33-bin
    electron-bin
    vesktop
    thunderbird
    power-profiles-daemon
    brightnessctl
    alejandra
    git
    git-lfs
    gcc
    rofi
    teams-for-linux
    wayland
    woomer
    xdg-utils
    glib
    grim
    slurp
    unstable.shikane
    networkmanagerapplet
    blueman
    fw-ectool
    xfce.thunar
    nautilus
    killall
    # libreoffice-qt6-still
    libreoffice-fresh
    onlyoffice-desktopeditors
    rustup
    btop
    dunst
    libnotify
    file
    jq
    satty
    unstable.protonvpn-gui
    fastfetch
    sublime3
    corrupter
    feh
    cmatrix
    cbonsai
    asciiquarium-transparent
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    obsidian
    syncthing
    auto-cpufreq
    tela-icon-theme
    gtk2
    gtk3
    gtk4
    gnome-themes-extra
    gimp
    vscode

    # Python
    (python312.withPackages (ps: [
      ps.requests
      ps.matplotlib
      ps.numpy
      ps.pyperclip
      ps.mysql-connector
    ]))

    cmake
    gnumake
    fd
    tealdeer
    greetd.greetd
    greetd.tuigreet
    uwufetch
    graphite-cursors
    nwg-look
    nwg-displays
    lxappearance-gtk2
    dconf
    fishPlugins.foreign-env
    wl-mirror
    fortune
    cowsay
    dotacat
    superTuxKart
    # ciscoPacketTracer8
    platformio
    platformio-core
    ffmpeg
    inotify-tools
    stress
    zip
    unzip
    thefuck
    unstable.nodePackages.npm
    rpi-imager
    cups
    google-chrome
    geogebra6
    hyprpicker
    vlc
    busybox
    jmtpfs
    nix-ld
    blender
    direnv
    any-nix-shell
    wev
    galculator
    sshpass
    jre8
    adoptopenjdk-icedtea-web
    nss.tools
    nss
    wireshark
    cron
    apacheHttpd
    openssl
    baobab
    losslesscut-bin
    wireguard-tools
    wireguard-ui
    nixos-anywhere
    platformio-core
    openocd
    gamemode
    tcpdump
    iperf
    pinentry-all

    # Audio
    pavucontrol
    pwvucontrol
    pamixer
    pipewire
    wireplumber
  ];

  programs = {
    fish.enable = true;
    waybar.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-all;
      # enableSSHSupport = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        libglvnd
        stdenv.cc.cc.lib
      ];
    };
    steam.enable = true;
    wireshark.enable = true;
  };

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    power-profiles-daemon.enable = true;
    dbus.enable = true;
    ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "11.0.2";
    };
  };
}
