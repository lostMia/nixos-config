{
  config,
  pkgs,
  ...
}: {
  security.pam.services.swaylock = {
    text = ''
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth sufficient pam_fprintd.so
      auth include login
    '';
  };
  security.pam.services.swaylock.fprintAuth = true;
}
