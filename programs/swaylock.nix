{
  config,
  pkgs,
  ...
}: {
  programs.swaylock = {
    enable = true;
    settings = {
      # daemonize = true;
      # show-failed-attempts = true;
      # show-keyboard-layout = true;
      # ignore-empty-password = true;
      fingerprint = true;
      image = "$HOME/Pictures/Screenshots/screen.png";
      # indicator-radius = 200;
      # indicator-thickness = 10;
      # inside-color = "#00000000";
      # line-color = "#00000000";
      # ring-color = "#00000000";
      # text-color = "#00000000";
      #
      # layout-bg-color = "#00000000";
      # layout-text-color = "#00000000";
      #
      # inside-clear-color = "#00000000";
      # line-clear-color = "#00000000";
      # ring-clear-color = "#ffff99";
      # text-clear-color = "#00000000";
      #
      # inside-ver-color = "#00000000";
      # line-ver-color = "#00000000";
      # ring-ver-color = "#70ffff";
      # text-ver-color = "#00000000";
      #
      # inside-wrong-color = "#00000000";
      # line-wrong-color = "#00000000";
      # ring-wrong-color = "#ff5555";
      # text-wrong-color = "#00000000";
      #
      # bs-hl-color = "#ff5555";
      # key-hl-color = "#99ff99";
      #
      # text-caps-lock-color = "#ffffff";
    };
  };
}
