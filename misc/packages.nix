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
    firefox
    flameshot
    swayfx
    wl-clipboard
    zoxide
    unstable.alacritty
    keepassxc
    bash
    waybar
    autotiling
    signal-desktop
    electron
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
    sway-audio-idle-inhibit
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
    neofetch
    sublime3
    swayidle
    corrupter
    feh
    cmatrix
    cbonsai
    asciiquarium-transparent
    xdg-desktop-portal
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
    python3
    python312Packages.requests
    python312Packages.tqdm
    python312Packages.matplotlib
    # python312Packages.cmake
    cmake
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
    ciscoPacketTracer8
    platformio
    platformio-core
    ffmpeg
    inotify-tools
    swayosd
    stress
    zip
    unzip
    thefuck
    unstable.nodePackages.npm
    python312Packages.pyperclip
    python312Packages.numpy
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
    nix-ld.enable = true;
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

  programs.nix-ld.libraries = with pkgs; [
    zlib
    libglvnd
    stdenv.cc.cc.lib
  ];
}
