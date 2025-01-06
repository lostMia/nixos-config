{...}: {
  # This is currently not in use, because we use a community created fork from swaylock (swaylock-fprint) where we don't have to mess with PAM :)
  # security.pam.services.swaylock = {};
  # security.pam.services.swaylock = {
  #   text = ''
  #     auth sufficient pam_unix.so try_first_pass likeauth nullok
  #     auth sufficient pam_fprintd.so
  #     auth include login
  #   '';
  # };
  # security.pam.services.swaylock.fprintAuth = true;
  # security.pam.swaylock = {};
}
