{config, ...}: {
  networking.hostName = "nixos";

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

  # networking.networkmanager = {
  #   enable = true;
  #   config = {
  #     connections = [
  #       {
  #         connection.id = "wlan0";
  #         connection.interface-name = "wlan0";
  #         wifi.mac-address = "14:ac:60:d8:2c:07";
  #         type = "wifi";
  #       }
  #       {
  #         connection.id = "eth0";
  #         connection.interface-name = "eth0";
  #         ethernet.mac-address = "9c:bf:0d:00:49:7d";
  #         type = "ethernet";
  #       }
  #     ];
  #   };
  # };

  # networking.interfaces.eth0.useDHCP = true;

  networking.networkmanager.enable = true;

  # systemd.network.links."10-fwwlan0" = {
  #   matchConfig.PermanentMACAddress = "14:ac:60:d8:2c:07";
  #   linkConfig.Name = "fwwlan0";
  # };
  # systemd.network.links."10-eth0" = {
  #   matchConfig.PermanentMACAddress = "9c:bf:0d:00:49:7d";
  #   linkConfig.Name = "fweth0";
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  networking.wireguard.interfaces = {
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = ["192.168.1.200/24"];
      listenPort = 51820;
      privateKeyFile = "/home/mia/Documents/Wireguard/private";

      peers = [
        {
          publicKey = "zbvvV6yFulneB5HeIuinjbOQrUn51Z72CUYKDH0l9WQ=";
          # Forward all the traffic via VPN.
          allowedIPs = ["0.0.0.0/0"];
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          # Set this to the server IP and port.
          endpoint = "77.75.24.122:21975";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # networking.interfaces.br0.useDHCP = true;
  # networking.bridges = {
  #   "br0" = {
  #     interfaces = ["eth0"];
  #   };
  # };

  # services.httpd = {
  #   enable = true;
  #   enablePHP = true;
  #
  #   virtualHosts = {
  #     localhost = {
  #       hostName = "localhost";
  #       documentRoot = "/srv";
  #       forceSSL = true;
  #       sslServerCert = "/etc/ssl/certs/www-miau.crt";
  #       sslServerKey = "/etc/ssl/private/www-miau.key";
  #     };
  #   };
  # };
  #
  # systemd.tmpfiles.rules = [
  #   "d /srv 0775 ${config.services.httpd.user} ${config.services.httpd.group}"
  #   "d /etc/ssl/certs 0775 ${config.services.httpd.user} ${config.services.httpd.group}"
  #   "d /etc/ssl/private 0775 ${config.services.httpd.user} ${config.services.httpd.group}"
  # ];
  #
  # users.users.mia.extraGroups = [
  #   config.services.httpd.group
  # ];
}
