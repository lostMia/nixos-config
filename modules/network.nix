{
  config,
  pkgs,
  unstable,
  ...
}: {
  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # networking.interfaces.br0.useDHCP = true;
  # networking.bridges = {
  #   "br0" = {
  #     interfaces = ["eth0"];
  #   };
  # };

  # networking.interfaces.eth0.useDHCP = true;

  # stuff from matteo
  # systemd.network.links."10-f13wlan0" = {
  #   matchConfig.PermanentMACAddress = "dc:97:ba:bf:85:a6";
  #   linkConfig.Name = "f13wlan0";
  # };
  # systemd.network.links."10-f13eth0" = {
  #   matchConfig.PermanentMACAddress = "9c:bf:0d:00:90:6c";
  #   linkConfig.Name = "f13eth0";
  # };
}
