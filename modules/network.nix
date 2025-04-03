{lib, ...}: {
  networking.hostName = lib.mkDefault "nixos";

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = false;
      addresses = true;
      domain = true;
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
  # networking.firewall.allowedUDPPorts = [ 51520 13231 ];

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    interfaces.home = {
      useDHCP = false;
      ipv4.routes = [
        {
          address = "192.168.1.0";
          via = "192.168.100.1";
          prefixLength = 24;
        }
      ];
    };
  };

  # Wireguard Setup
  #   wireguard.interfaces = {
  #     home = {
  #       ips = ["192.168.100.2/24"];
  #       listenPort = 51820;
  #       mtu = 1280;
  #       privateKeyFile = "/home/mia/Documents/Wireguard/private_client";
  #       allowedIPsAsRoutes = false;
  #       metric = 1;
  #
  #       peers = [
  #         {
  #           presharedKeyFile = "/home/mia/Documents/Wireguard/preshared_key";
  #           publicKey = "1AjgOEb0DD/bhzq+drR4U3LKojwel9xbMu+YVH/0/jU=";
  #           allowedIPs = ["192.168.0.0/16"];
  #           # allowedIPs = [ "0.0.0.0/0" ];
  #           endpoint = "miauu.ddns.net:51820";
  #           persistentKeepalive = 25;
  #         }
  #       ];
  #     };
  #   };
  # };

  # Wireguard Setup with wg-quick
  networking.wg-quick.interfaces = {
    home = {
      address = ["192.168.100.2/24"];
      # dns = [ "10.0.0.1" ];
      privateKeyFile = "/home/mia/Documents/Wireguard/private_client";
      autostart = false;

      peers = [
        {
          publicKey = "1AjgOEb0DD/bhzq+drR4U3LKojwel9xbMu+YVH/0/jU=";
          presharedKeyFile = "/home/mia/Documents/Wireguard/preshared_key";
          allowedIPs = ["192.168.0.0/16"];
          endpoint = "miauu.ddns.net:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # networking.interfaces.home.ipv4.routes = [{
  #   address = "192.168.1";
  #   via = "192.168.100.1";
  #   prefixLength = 0;
  # }];

  # networking.defaultGateway = {
  #   address = "192.168.100.1";
  #   interface = "home";
  # };

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
