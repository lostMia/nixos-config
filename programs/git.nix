{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "lostmia";
    # Yes, really.
    userEmail = "testemail429455@gmail.com";

    extraConfig = ''
      [credential]
      	helper = nuh uh
      [init]
      	defaultBranch = main
    '';
  };
}
