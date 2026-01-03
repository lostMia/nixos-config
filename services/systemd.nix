{pkgs, ...}: {
  systemd = {
    sleep.extraConfig = ''
      AllowSuspendThenHibernate=yes
      AllowSuspend=yes
      SuspendDelaySec=3min
      HibernateDelaySec=120min
      SuspendState=freeze
      HibernateMode=shutdown
    '';

    services = {
      "NetworkManager-wait-online".enable = false;
      "docker".enable = false;
      "syncthing-init".enable = false;
      "systemd-networkd-wait-online.service".enable = false;
      # "cups".enable = false;
      # "wpa_supplicant".enable = false;
    };
  };

  services = {
    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "suspend-then-hibernate";
      HandleLidSwitchDocked = "suspend-then-hibernate";
      HandlePowerKey = "ignore";
    };

    # displayManager.ly = {
    #   enable = true;
    # };

    greetd = {
      enable = false;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "mia";
        };
      };
    };
  };
}
