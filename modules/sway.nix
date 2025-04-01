{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    swayfx
    sway-audio-idle-inhibit
    swayidle
    swayosd
  ];

  # Configure keymap in X11
  services.xserver = {
    enable = false;
    xkb = {
      layout = "de";
      variant = "bone";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  xdg.portal = {
    config.common.default = "*";
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
