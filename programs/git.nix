{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "lostmia";
    userEmail = "miaunterladstaetter@gmail.com";

    extraConfig = {
      credential = {
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        # credentialStore = "cache"; Only temporarily stores credentials in the store which is rather annoying.
        credentialStore = "secretservice";
      };
      # credential."https://git.htlec.org" = {
      #   helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      #   provider = "generic";
      # };
    };
  };

  programs.gh = {
    enable = true;
    # adds the gh as a credential helper to new ~/.config/git/config, replacing the old ~/.gitconfig
    gitCredentialHelper.enable = true;
    #gitCredentialHelper.hosts = [] # default is fine
  };
}
