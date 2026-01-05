{pkgs, ...}: {
  services.pcscd = {
    enable = true;
    plugins = [pkgs.acsccid];
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = ["polymarket"];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  environment.systemPackages = with pkgs; [
    gradle
  ];
}
