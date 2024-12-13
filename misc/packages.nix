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
    nur.repos.kira-bruneau.swaylock-fprintd
    # swaylock
    swayidle
    corrupter
    feh
    cmatrix
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
    fd
    tldr
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
    # Don't forget to get the debian Package first:
    # (nix-store --add-fixed sha256 Packet_Tracer822_amd64_signed.deb) // old
    # nix-store --add-fixed sha256 CiscoPacketTracer822_amd64_signed.deb
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
  ];

  programs = {
    fish.enable = true;
    waybar.enable = true;
    dconf.enable = true;
    nix-ld.enable = true;
    steam.enable = true;
  };

  # programs.nix-ld.libraries = with pkgs; [
  # ];

  services = {
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    dbus.enable = true;
  };
}
