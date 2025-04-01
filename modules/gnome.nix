{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cheese # webcam tool
    gnome-characters
    yelp # Help view
    gnome-initial-setup
  ];

  services.xserver.enable = lib.mkDefault true;
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;
}
