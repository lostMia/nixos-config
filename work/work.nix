{pkgs, ...}: {
  services.pcscd = {
    enable = true;
    plugins = [pkgs.acsccid];
  };

  environment.systemPackages = with pkgs; [
    gradle
  ];
}
