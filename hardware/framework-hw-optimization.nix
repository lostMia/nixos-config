{
  lib,
  pkgs,
  ...
}: {
  boot.kernelParams = [
    # For Power consumption
    # https://kvark.github.io/linux/framework/2021/10/17/framework-nixos.html
    "mem_sleep_default=deep"
    # For Power consumption
    # https://community.frame.work/t/linux-battery-life-tuning/6665/156
    # "nvme.noacpi=1"
    # ctsrgiencsrgtiersgctienrgsctienogrscsitne i hate this ~ mia, after spending 7 hours debugging this stupid shit
  ];

  # Requires at least 5.16 for working wi-fi and bluetooth.
  # https://community.frame.work/t/using-the-ax210-with-linux-on-the-framework-laptop/1844/89
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.16") (lib.mkDefault pkgs.linuxPackages_latest);

  # Fix TRRS headphones missing a mic
  # https://community.frame.work/t/headset-microphone-on-linux/12387/3
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=dell-headset-multi
  '';

  # For fingerprint support
  #services.fprintd.enable = lib.mkDefault true;

  # Custom udev rules
  services.udev.extraRules = ''
    # Fix headphone noise when on powersave
    # https://community.frame.work/t/headphone-jack-intermittent-noise/5246/55
    SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0xa0e0", ATTR{power/control}="on"
    # Ethernet expansion card support
    #ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="8156", ATTR{power/autosuspend}="20"
  '';

  # Mis-detected by nixos-generate-config
  # https://github.com/NixOS/nixpkgs/issues/171093
  # https://wiki.archlinux.org/title/Framework_Laptop#Changing_the_brightness_of_the_monitor_does_not_work
  hardware.acpilight.enable = lib.mkDefault true;

  # Needed for desktop environments to detect/manage display brightness
  hardware.sensor.iio.enable = lib.mkDefault true;

  services.fwupd.enable = true;

  # HiDPI
  # Leaving here for documentation
  #hardware.video.hidpi.enable = lib.mkDefault true;

  # Fix font sizes in X
  #services.xserver.dpi = 200;
}
