{pkgs, ...}: {
  services = {
    gnome.gnome-keyring.enable = true;
  };

  security.pam.services = {
    login = {
      enableGnomeKeyring = true;
      fprintAuth = true;
    };
    swaylock.enableGnomeKeyring = true;
    sudo.fprintAuth = true;
    polkit-1.fprintAuth = true;
  };
}
