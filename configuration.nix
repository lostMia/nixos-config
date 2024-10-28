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
    ./hardware-configuration.nix
    ./misc/udev-rules.nix
  ];

  nix.nixPath = [
    "nixos-config=/home/mia/.config/nixos/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.luks.devices."luks-83b3ed89-8d91-4d72-a61b-ad00a1819542".device = "/dev/disk/by-uuid/83b3ed89-8d91-4d72-a61b-ad00a1819542";
  boot.kernelParams = ["mem_sleep_default=deep"];

  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      splashImage = /boot/nix-bg.png;
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root 14EC-1168
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  systemd.sleep.extraConfig = ''
    AllowSuspendThenHibernate=yes
    AllowSuspend=yes
    SuspendEstimationSec=1min
    HibernateDelaySec=60min
    SuspendState=freeze
    HibernateMode=shutdown
  '';

  services.logind.extraConfig = ''
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchExternalPower=suspend-then-hibernate
    HandleLidSwitchDocked=suspend-then-hibernate
  '';

  networking.hostName = "nix";
  networking.networkmanager.enable = true;

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
    extraGroups = ["networkmanager" "wheel" "mia" "libvirtd" "kvm" "syncthing" "docker"];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    unstable.neovim
    unstable.neovide
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
    unstable.shikane
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
    obsidian
    syncthing
    auto-cpufreq
    tela-icon-theme
    graphite-gtk-theme
    gimp
    vscode
    python3
    fd
    tldr
    pamixer
    pipewire
    wireplumber
    pavucontrol
    greetd.greetd
    greetd.tuigreet
    uwufetch
    graphite-gtk-theme
    nwg-look
    nwg-displays
    lxappearance-gtk2
    dconf
    fishPlugins.foreign-env

    # Don't forget to get the debian Package first:
    # nix-store --add-fixed sha256 Packet_Tracer822_amd64_signed.deb
    ciscoPacketTracer8

    platformio
    platformio-core
  ];

  virtualisation.libvirtd = {
    allowedBridges = [
      "virbr0"
      "br0"
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  services = {
    syncthing = {
      enable = true;
      user = "mia";
      dataDir = "/home/mia/Documents";
      configDir = "/home/mia/Documents/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "android-phone" = {id = "GN7CLEC-K73TLQF-H6KR46Z-7FXJ75F-N4PS4GG-BLLGE3M-SYZWLME-P2ZIIAN";};
        };
        folders = {
          "zepr3-bryuh" = {
            path = "/home/mia/Password/";
            devices = ["android-phone"];
          };
          "j9zfq-wexpg" = {
            path = "/home/mia/Notes/";
            devices = ["android-phone"];
            ignorePerms = false;
          };
        };
      };
    };
  };

  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.pulseaudio.enable = false;

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "mia";
      };
    };
  };

  hardware.opengl.extraPackages = [
    pkgs.amdvlk
  ];

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

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

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

  services.openssh = {
    enable = true;
    ports = [21888];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["mia"];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  services = {
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    fprintd.enable = true;
    dbus.enable = true;
    blueman.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # networking.interfaces.eth0.useDHCP = true;
  # networking.interfaces.br0.useDHCP = true;
  # networking.bridges = {
  #   "br0" = {
  #     interfaces = ["eth0"];
  #   };
  # };

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
