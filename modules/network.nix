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

  # https://wiki.nixos.org/wiki/Netbird#Basic_Client_Setup
  services.netbird = {
    enable = true;
    clients.ppc = {
      # login = {
      #   enable = true;
      #   setupKeyFile = "/root/netbird/ppc_key";
      # };

      port = 46733;
      ui.enable = false;
      openFirewall = true;
      # openInternalFirewall = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    # interfaces.home = {
    #   useDHCP = false;
    #   # virtualType = "tun";
    #   # virtual = true;
    #   ipv4.routes = [
    #     {
    #       address = "192.168.1.0";
    #       via = "192.168.100.1";
    #       prefixLength = 24;
    #       type = "local";
    #     }
    #   ];
    # };
  };

  # Wireguard Setup with wg-quick
  networking.wg-quick.interfaces = {
    home = {
      address = ["192.168.100.2/24"];
      privateKeyFile = "/root/wireshark-keys/private_client";
      autostart = false;

      postUp = ''
        ip route add 192.168.1.0/24 via 192.168.100.1
      '';
      postDown = ''
        ip route del 192.168.1.0/24 via 192.168.100.1
      '';

      peers = [
        {
          publicKey = "1AjgOEb0DD/bhzq+drR4U3LKojwel9xbMu+YVH/0/jU=";
          presharedKeyFile = "/root/wireshark-keys/preshared_key";
          allowedIPs = ["192.168.0.0/16"];
          # allowedIPs = ["0.0.0.0/0"];
          endpoint = "miauu.ddns.net:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
