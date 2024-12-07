{
  config,
  pkgs,
  nur,
  old,
  unstable,
  very-unstable,
  hardware,
  ...
}: {
  imports = [
    ./hardware/framework-13.nix
    ./hardware/framework-hw-optimization.nix
    ./modules/audio.nix
    ./modules/network.nix
    ./modules/bluetooth.nix
    ./modules/graphical.nix
    ./modules/virtualisation.nix
    ./modules/pam.nix
    ./services/systemd.nix
    ./services/syncthing.nix
    ./services/ssh.nix
    ./users/mia.nix
    ./misc/udev-rules.nix
    ./misc/packages.nix
  ];

  nix.nixPath = [
    "nixos-config=/home/mia/.config/nixos/configuration.nix"
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
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Hack"];})
  ];

  # Automatic upgrades and stuff.
  system.autoUpgrade = {
    enable = true;
    flake = "/home/mia/.config/nixos/flake.nix";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
      "-L"
    ];
    dates = "weekly";
    randomizedDelaySec = "45min";
  };

  # Garbage collection stuffs.
  nix.gc = {
    randomizedDelaySec = "60min";
    persistent = true;
    dates = "weekly";
    automatic = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment? Yes, I just don't care ~ mia
}
