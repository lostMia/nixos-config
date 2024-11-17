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

    extraConfig = {
      credential.helper = "store";
      init.defaultBranch = "main";
    };
  };
}
