# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  unstable = import <unstable> {config = {allowUnfree = true;};};
in {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.nixPath = [
    "nixos-config=/home/mia/.config/nixos/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-83b3ed89-8d91-4d72-a61b-ad00a1819542".device = "/dev/disk/by-uuid/83b3ed89-8d91-4d72-a61b-ad00a1819542";
  networking.hostName = "nix";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

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
    flameshot
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
    xfce.thunar
    pamixer
    killall
  ];

  services.dbus.enable = true;

  systemd.services.ly = {
    description = "Ly Display Manager";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${unstable.ly}/bin/ly";
      Restart = "always";
    };
  };

  # Disable any other display managers (like GDM, SDDM, etc.)
  #services.xserver.enable = false;

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
    udisks2 = {
      enable = true;
    };
    power-profiles-daemon = {
      enable = true;
    };
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

  system.stateVersion = "24.05"; # Did you read the comment?
}
