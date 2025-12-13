{
  pkgs,
  nur,
  unstable,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    vim
    wget
    fish
    firefox
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
    power-profiles-daemon
    brightnessctl
    alejandra
    git
    git-lfs
    gcc
    rofi
    wayland
    xdg-utils
    glib
    grim
    slurp
    unstable.shikane
    sway-audio-idle-inhibit
    nautilus
    killall
    btop
    dunst
    libnotify
    file
    jq
    fastfetch
    swayidle
    corrupter
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    python312.withPackages
    fd
    tealdeer
    greetd
    tuigreet
    nwg-displays
    fishPlugins.foreign-env
    wl-mirror
    swayosd
    stress
    zip
    unzip
    jmtpfs
    nix-ld
    direnv
    any-nix-shell
    sshpass
    openssl
    nixos-anywhere

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
    steam.enable = false;
    wireshark.enable = false;
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
