{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../hardware/desktop.nix
    ../modules/audio.nix
    ../modules/network.nix
    ../modules/bluetooth.nix
    ../modules/gnome.nix
    ../modules/virtualisation.nix
    # ../modules/pam.nix # read the note in the file
    # ../modules/cups.nix
    ../services/systemd.nix
    ../services/syncthing.nix
    ../services/ssh.nix
    # ../services/cron.nix
    ../users/mia.nix
    # ../misc/udev-rules.nix
    ../misc/packages.nix
  ];

  nix.nixPath = [
    "nixos-config=/home/mia/.config/nixos/hosts/desktop.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/656c3977-1ff4-4e13-a3fa-38e2e58f93c9";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-5214b64e-a0ec-4e6f-b389-9329c6146eef".device = "/dev/disk/by-uuid/5214b64e-a0ec-4e6f-b389-9329c6146eef";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4151-8F42";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  # Enable Vulkan support for NVIDIA
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true; # 32-bit support for some games or apps
  hardware.opengl.extraPackages = with pkgs; [
    vulkan-tools # Vulkan utilities
    vulkan-validation-layers
  ];

  hardware.graphics = {
    enable = true;
  };

  # Enable NVIDIA proprietary drivers
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp34s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
