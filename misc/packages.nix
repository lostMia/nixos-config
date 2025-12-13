{
  pkgs,
  nur,
  unstable,
  packages,
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
    # firefox-unwrapped
    # firefox
    # firefox-esr
    # firefox-bin-unwrapped
    # unstable.flameshot
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
    unstable.signal-desktop
    electron-bin
    vesktop
    thunderbird
    power-profiles-daemon
    brightnessctl
    alejandra
    git
    git-lfs
    git-credential-manager
    gcc
    rofi
    unstable.teams-for-linux
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
    # gnome-themes-extra
    gnome-keyring
    gimp
    vscode
    # jetbrains.idea-community-bin
    jetbrains.idea-ultimate
    awscli2

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
    greetd
    tuigreet
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
    pay-respects
    unstable.nodePackages.npm
    cups
    google-chrome
    chromium
    chromedriver
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
    nss.tools
    nss
    nspr
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
    tor-browser
    qbittorrent
    comic-mono
    comic-relief
    cum # because..... because? okay?
    # packages.waybar-timer
    obs-studio
    kdePackages.kdenlive
    jrnl
    appimage-run
    appimageupdate
    playerctl
    wayfreeze
    gdb
    remmina
    poppler-utils
    # jetbrains.jdk
    jetbrains.jdk-no-jcef

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
    };
    steam.enable = true;
    wireshark.enable = true;
  };

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    dbus.enable = true;
    ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "11.0.2";
    };
  };
}
