{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd" "amdgpu"];
    extraModulePackages = [];
    extraModprobeConfig = ''
      options snd-hda-intel model=dell-headset-multi
    '';

    kernelPackages = pkgs.linuxPackages_zen;
    initrd.luks.devices."luks-83b3ed89-8d91-4d72-a61b-ad00a1819542".device = "/dev/disk/by-uuid/83b3ed89-8d91-4d72-a61b-ad00a1819542";
    initrd.luks.devices."luks-52dfdba5-d0dc-48c6-86c0-4a6c18db1d36".device = "/dev/disk/by-uuid/52dfdba5-d0dc-48c6-86c0-4a6c18db1d36";
    kernelParams = ["mem_sleep_default=deep" "console=tty1"];
    kernel.sysctl = {
      "kernel.sysrq" = 1;
    };

    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      timeout = 3;
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
        configurationLimit = 5;
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        splashImage = ../resources/nix.png;
      };
    };
  };

  hardware = {
    acpilight.enable = lib.mkDefault true;
    sensor.iio.enable = lib.mkDefault true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/65af7577-3f46-4561-814d-96ed897920f4";
      fsType = "btrfs";
      options = ["subvol=@"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/CC55-CE6E";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/c6c5fa2e-795f-4988-bffb-d00c971a0745";}
  ];

  networking.useDHCP = lib.mkDefault true;

  services = {
    fprintd.enable = lib.mkDefault true;
    fwupd.enable = lib.mkDefault true;

    udev.extraRules = ''
      # Fix headphone noise when on powersave
      # https://community.frame.work/t/headphone-jack-intermittent-noise/5246/55
      SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0xa0e0", ATTR{power/control}="on"
      # Ethernet expansion card support
      #ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="8156", ATTR{power/autosuspend}="20"
    '';
  };
}
