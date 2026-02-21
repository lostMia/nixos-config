{pkgs, ...}: {
  services = {
    gnome.gnome-keyring.enable = true;
  };

  security = {
    soteria.enable = true;
    polkit.enable = true;
    pam.services = {
      keepass.fprintAuth = true;
      keepassxc.fprintAuth = true;
      login = {
        enableGnomeKeyring = true;
        fprintAuth = true;
      };
      swaylock.enableGnomeKeyring = true;
      sudo.fprintAuth = true;
      polkit-1.fprintAuth = true;
    };
  };
}
