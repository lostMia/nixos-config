{
  pkgs,
  nur,
  ...
}: {
  imports = [
    ./programs/git.nix
    ./programs/alacritty.nix
    ./programs/fish.nix
    ./programs/waybar.nix
    ./programs/shikane.nix
    ./programs/sway.nix
    ./programs/swaylock.nix
    ./programs/rofi.nix
    # ./programs/auto-cpu.nix # Read the comment in the file.
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mia";
  home.homeDirectory = "/home/mia";

  # You should not change this value, even if you update Home Manager. If you do

  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (graphite-gtk-theme.override {
      tweaks = ["darker" "normal"];
      themeVariants = ["pink"];
    })
    tela-icon-theme
    bibata-cursors
    dracula-qt5-theme
    dracula-theme
    mariadb
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # qt.enable = true;
  # qt.style.name = "Dracula";
  #
  gtk = {
    enable = true;
    theme = {
      name = "Graphite-pink-Dark";
      package = pkgs.graphite-gtk-theme;
    };
    iconTheme = {
      name = "Tela-black";
      package = pkgs.tela-icon-theme;
    };
    cursorTheme = {
      name = "Graphite dark Cursors";
      package = pkgs.graphite-cursors;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors; # Specify the cursor theme package
    name = "Bibata-Modern-Ice"; # Specify the cursor theme name
    size = 64;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.file.".mozilla/firefox/mia/chrome/".source = let
    cascade = pkgs.callPackage ./src/cascade/cascade.nix {};
  in "${cascade}";

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mia/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # systemd.user = {
  #   services.matteo-syncthing = {
  #     Unit = {
  #       Description = "Syncthing Dir Change Checker";
  #     };
  #
  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = "${pkgs.bash}/bin/bash /home/mia/.config/nixos/scripts/check_for_directory_change.sh";
  #       Environment = "DISPLAY=:0.0";
  #       Path = with pkgs; [ libnotify dbus coreutils bash which ];
  #     };
  #   };
  #
  #   timers.matteo-syncthing = {
  #     Timer = {
  #       OnBootSec = "1m";
  #       OnUnitActiveSec = "1m";
  #       Unit = "matteo-syncthing.service";
  #     };
  #     Install.WantedBy = [ "default.target" ];
  #   };
  # };

  # home.file

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    eza = {
      enable = true;
      extraOptions = [
        "-g"
      ];
    };
  };
}
