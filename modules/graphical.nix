{
  config,
  pkgs,
  ...
}: {
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "bone";
  };

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  hardware.opengl.extraPackages = [
    pkgs.amdvlk
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.xserver.enable = false;
}
