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
      core.editor = "nvim";
      core.color.ui = true;
      core.pager = "delta";
    };

    config = ''
      [credential]
      	helper = store
      [init]
      	defaultBranch = main
    '';
  };
}
