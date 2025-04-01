{config, ...}: {
  networking.hostName = "nixos";

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
  networking.firewall.allowedUDPPorts = [13231];

  # networking.wireguard.interfaces = {
  #   home = {
  #     ips = ["192.168.1.200/24"];
  #     listenPort = 13231;
  #     # privateKeyFile = "/home/mia/Documents/Wireguard/privatekey";
  #     privateKey = "QKQtTxwCpAUasUOBZobMl1R8J6SLTJ/OsCt/9E7Z2FU=";
  #
  #     peers = [
  #       {
  #         publicKey = "kIQeU5Wffq778OkZEUPKbl2tpVHeYesxsls5qvcDr2Q=";
  #         # Forward all the traffic via VPN.
  #         allowedIPs = [ "0.0.0.0/0" ];
  #
  #         # Or only forward anything destined for the home network.
  #         # allowedIPs = ["10.0.0.1/24"];
  #
  #         # Set this to the server IP and port.
  #         endpoint = "77.75.24.122:13231";
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };

  # networking.wg-quick.interfaces = {
  #   wg0 = {
  #     address = [ "10.100.0.2/24" ];
  #     listenPort = 51820;
  #     # dns = [ "10.0.0.1" ];
  #     # privateKey = "QKQtTxwCpAUasUOBZobMl1R8J6SLTJ/OsCt/9E7Z2FU=";
  #     privateKey = "uNmaadC/y3feorkcQ4issLvNzQFxEGSraV+W12w+i0Y=";
  #
  #     peers = [
  #       {
  #         publicKey = "noRWD4CwdDzw9fmDBsMVZfNZ5fQerhMdGWkyiTULQiE=";
  #         # presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
  #         allowedIPs = [ "0.0.0.0/0" ];
  #         endpoint = "10.5.6.144:51820";
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
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
