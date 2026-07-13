{...}: {
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    libvirtd = {
      enable = true;
      allowedBridges = [
        "virbr0"
        "br0"
      ];
    };
  };
  programs.virt-manager.enable = true;
}
