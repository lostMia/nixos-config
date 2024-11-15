{
  config,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    ports = [21888];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["mia"];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
}
