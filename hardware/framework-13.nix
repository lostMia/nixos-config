{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./framework-hw-optimization.nix
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd" "amdgpu"];
  boot.extraModulePackages = [];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.luks.devices."luks-83b3ed89-8d91-4d72-a61b-ad00a1819542".device = "/dev/disk/by-uuid/83b3ed89-8d91-4d72-a61b-ad00a1819542";
  boot.initrd.luks.devices."luks-52dfdba5-d0dc-48c6-86c0-4a6c18db1d36".device = "/dev/disk/by-uuid/52dfdba5-d0dc-48c6-86c0-4a6c18db1d36";
  boot.kernelParams = ["mem_sleep_default=deep" "console=tty1"];
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  hardware.graphics.extraPackages = [
    pkgs.amdvlk
  ];

  boot.loader = {
    timeout = 0;
    grub = {
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
      timeoutStyle = "hidden";
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/65af7577-3f46-4561-814d-96ed897920f4";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CC55-CE6E";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/c6c5fa2e-795f-4988-bffb-d00c971a0745";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp195s0f4u1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  services.fprintd.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
