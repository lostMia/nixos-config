{pkgs, ...}: {
  networking.hostName = "mingming";

  imports = [
    ../hardware/framework-13.nix
    ../modules/audio.nix
    ../modules/network.nix
    ../modules/bluetooth.nix
    ../modules/sway.nix
    # ../modules/gnome.nix
    ../modules/virtualisation.nix
    ../modules/cups.nix
    ../services/systemd.nix
    ../services/security.nix
    ../services/syncthing.nix
    ../services/ssh.nix
    ../services/db.nix
    # ../services/cron.nix
    ../users/mia.nix

    # Work related configurations (shh :3)
    ../work/work.nix

    ../misc/udev-rules.nix
    ../misc/packages.nix
  ];

  nix.nixPath = [
    "nixos-config=/home/mia/.config/nixos/hosts/framework-13.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  time.timeZone = "Europe/Vienna";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Configure console keymap
  console.keyMap = "bone";

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
    LC_COLLATE = "de_AT.UTF-8";
  };

  environment.variables = {
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    GTK_BACKEND = "wayland,x11";
    MOZ_ENABLE_WAYLAND = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = 0;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.comic-shanns-mono
  ];

  # Automatic upgrades and stuffs.
  system.autoUpgrade = {
    enable = true;
    flake = "flake.nix";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
      "-L"
    ];
    dates = "weekly";
    randomizedDelaySec = "45min";
  };

  # Garbage collection and stuffs.
  nix.gc = {
    randomizedDelaySec = "60min";
    persistent = true;
    dates = "monthly";
    automatic = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment? Yes, I just don't care ~ mia
}
