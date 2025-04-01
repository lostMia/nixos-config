{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cheese # webcam tool
    gnome-characters
    yelp # Help view
    gnome-initial-setup
  ];

  # Configure keymap in X11
  services.xserver = {
    enable = false;
    xkb = {
      layout = "de";
      variant = "bone";
    };
  };

  xdg.portal = {
    config.common.default = "*";
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;
}
