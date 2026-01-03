{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mia = {
    isNormalUser = true;
    description = "mia";
    extraGroups = ["networkmanager" "wheel" "mia" "libvirtd" "kvm" "syncthing" "docker" "wireshark" "mysql"];
    packages = [];
  };

  users.users.root = {
    packages = [
      pkgs.bashInteractive
    ];
    shell = pkgs.bashInteractive;
  };

  # fish ><> :>
  users.defaultUserShell = pkgs.fish;
}
