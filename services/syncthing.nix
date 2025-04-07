{...}: {
  services.syncthing = {
    enable = true;
    user = "mia";
    dataDir = "/home/mia/Documents";
    configDir = "/home/mia/Documents/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "android-phone" = {id = "GN7CLEC-K73TLQF-H6KR46Z-7FXJ75F-N4PS4GG-BLLGE3M-SYZWLME-P2ZIIAN";};
        "matteo-laptop" = {id = "OV7VF4Z-JGZN6EN-JYFKQDJ-JTQKS27-CQK5OUU-FUL7LSS-QCGRU35-7KAHYA2";};
      };
      folders = {
        "zepr3-bryuh" = {
          path = "/home/mia/Password/";
          devices = ["android-phone"];
        };
        "j9zfq-wexpg" = {
          path = "/home/mia/Notes/";
          devices = ["android-phone"];
          ignorePerms = false;
        };
        "yqzvc-zvvkq" = {
          path = "/home/mia/Documents/Matteo";
          devices = ["matteo-laptop"];
          ignorePerms = false;
        };
      };
    };
  };
}
