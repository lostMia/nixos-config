{
  config,
  pkgs,
  unstable,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    neovide
    vim
    wget
    fish
    unstable.firefox
    swayfx
    wl-clipboard
    zoxide
    alacritty
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
    xdg-utils
    glib
    grim
    slurp
    unstable.shikane
    networkmanagerapplet
    blueman
    sway-audio-idle-inhibit
    fw-ectool
    fwupd
    xfce.thunar
    gnome.nautilus
    killall
    # libreoffice-qt6-still
    # libreoffice
    btop
    dunst
    libnotify
    file
    jq
    protonvpn-cli_2
    satty
    neofetch
    sublime3
    fprintd
    config.nur.repos.kira-bruneau.swaylock-fprintd
    corrupter
    feh
    cmatrix
    flameshot
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    obsidian
    syncthing
    auto-cpufreq
    tela-icon-theme
    gtk2
    gtk3
    gtk4
    gnome.gnome-themes-extra
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
    steam
  ];

  programs = {
    waybar.enable = true;
    fish.enable = true;
    dconf.enable = true;
    nix-ld.enable = true;
  };

  services = {
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    dbus.enable = true;
  };
}