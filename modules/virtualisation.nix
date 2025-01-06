{...}: {
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    allowedBridges = [
      "virbr0"
      "br0"
    ];
  };
}
