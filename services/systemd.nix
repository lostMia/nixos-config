{
  config,
  pkgs,
  ...
}: {
  systemd.sleep.extraConfig = ''
    SuspendEstimationSec=1min
    HibernateDelaySec=60min
    SuspendState=freeze
  '';

  services.logind.extraConfig = ''
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchExternalPower=suspend-then-hibernate
    HandleLidSwitchDocked=suspend-then-hibernate
  '';

  services.logind.powerKey = "ignore";

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
