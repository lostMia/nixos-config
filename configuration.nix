# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  # nixos-hardware/framework/13-inch/7040-amd> for framework specific stuff (todo)
  unstable = import <unstable> {config = {allowUnfree = true;};};
  nur =
    import (builtins.fetchTarball {
      url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    }) {
      inherit pkgs;
    };
  /*
  xdg_old = import (pkgs.fetchFromGitHub {
    owner = "flatpak";
    repo = "xdg-desktop-portal";
    rev = "bd1eab9";
    sha256 = "MD1zjKDWwvVTui0nYPgvVjX48DaHWcP7Q10vDrNKYz0="; # Replace with the correct hash
  }) {};
  */
in {
  imports = [
    <unstable/nixos/modules/services/display-managers/ly.nix>
    ./hardware-configuration.nix
  ];

  nix.nixPath = [
    "nixos-config=/home/mia/.config/nixos/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-83b3ed89-8d91-4d72-a61b-ad00a1819542".device = "/dev/disk/by-uuid/83b3ed89-8d91-4d72-a61b-ad00a1819542";
  boot.kernelParams = ["mem_sleep_default=deep"];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=60m
    SuspendState=mem
  '';

  services.logind.extraConfig = ''
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchExternalPower=suspend-then-hibernate
    HandleLidSwitchDocked=suspend-then-hibernate
  '';

  networking.hostName = "nix";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "bone";
  };

  # Configure console keymap
  console.keyMap = "bone";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mia = {
    isNormalUser = true;
    description = "mia";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.fish;

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
    unstable.ly
    autotiling
    signal-desktop
    electron
    vesktop
    thunderbird
    power-profiles-daemon
    pavucontrol
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
    shikane
    networkmanagerapplet
    blueman
    sway-audio-idle-inhibit
    fw-ectool
    fwupd
    xfce.thunar
    killall
    libreoffice-qt6-still
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
    nur.repos.kira-bruneau.swaylock-fprintd
    corrupter
    feh
    pwvucontrol
    cmatrix
    flameshot
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    dolphin
    obsidian
    syncthing
    auto-cpufreq
    tela-icon-theme
    graphite-gtk-theme
    gimp
    vscode
  ];

  environment.variables = {
    GTK_THEME = "Adwaita:dark";
  };

  services.displayManager.ly = {
    enable = true;
  };

  services.xserver.enable = false;

  services.fwupd.enable = true;

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Hack"];})
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    waybar = {
      enable = true;
    };
    fish = {
      enable = true;
    };
  };

  # services.openssh.enable = true;

  services = {
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    fprintd.enable = true;
    dbus.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.autoUpgrade = {
    enable = true;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "09:00";
    randomizedDelaySec = "45min";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
