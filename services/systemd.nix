{
  config,
  pkgs,
  ...
}: {
  systemd.sleep.extraConfig = ''
    AllowSuspendThenHibernate=yes
    AllowSuspend=yes
    SuspendEstimationSec=1min
    HibernateDelaySec=60min
    SuspendState=freeze
    HibernateMode=shutdown
  '';
  services.logind.extraConfig = ''
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchExternalPower=suspend-then-hibernate
    HandleLidSwitchDocked=suspend-then-hibernate
  '';
  services.logind.powerKey = "ignore";

  systemd.services."NetworkManager-wait-online".enable = false;
  # systemd.services."docker".enable = false;
  systemd.services."syncthing-init".enable = false;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "mia";
      };
    };
  };
}
