{pkgs, ...}: {
  systemd = {
    sleep.extraConfig = ''
      AllowSuspendThenHibernate=yes
      AllowSuspend=yes
      SuspendEstimationSec=2min
      HibernateDelaySec=60min
      SuspendState=freeze
      HibernateMode=shutdown
    '';

    services = {
      # "NetworkManager-wait-online".enable = false;
      # "docker".enable = false;
      "syncthing-init".enable = false;
      "CUPS".enable = false;
      "wpa_supplicant".enable = false;
    };
  };

  services = {
    logind.extraConfig = ''
      HandleLidSwitch=suspend-then-hibernate
      HandleLidSwitchExternalPower=suspend-then-hibernate
      HandleLidSwitchDocked=suspend-then-hibernate
    '';
    logind.powerKey = "ignore";

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "mia";
        };
      };
    };
  };
}
