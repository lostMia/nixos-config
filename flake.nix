{
  description = "Mia's (WIP) NixOS Flake :3";

  # - - - - - - - - - - - - - - - - - - - - - - - - Caches - - - - - - - - - - - - - - - - - - - - - - - #

  # Shamelessly stolen from https://github.com/Lord-Valen/configuration.nix/blob/master/flake.nix
  nixConfig = {
    extra-substituters = [
      # nix-community
      "https://nix-community.cachix.org"
      # aagl
      "https://ezkea.cachix.org"
      # colmena
      "https://colmena.cachix.org"
      # # cosmic
      # "https://cosmic.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  # - - - - - - - - - - - - - - - - - - - - - - - - Inputs - - - - - - - - - - - - - - - - - - - - - - - - #

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; # Stable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # Unstable
    nixpkgs-very-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small"; # Unstable - Small (Living on the edqe....)
    nurpkgs.url = "github:nix-community/NUR"; # NUR Repo
    hardware.url = "github:NixOS/nixos-hardware"; # NixOS Hardware
    home-manager = {
      # Home-Manager
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # agenix.url = "github:ryantm/agenix";
  };

  # - - - - - - - - - - - - - - - - - - - - - - - - Outputs - - - - - - - - - - - - - - - - - - - - - - - #

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-very-unstable,
    nurpkgs,
    hardware,
    home-manager,
    # agenix,
    ...
  } @ inputs: let
    stable = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    unstable = import nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    very-unstable = import nixpkgs-very-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    nur = import nurpkgs {};

    specialArgs = {
      inherit inputs self stable unstable very-unstable nur;
      system = "x86_64-linux";
      pkgs = stable;
    };
  in {
    # Collection of NixOS System Configurations.
    nixosConfigurations = {
      "ming" = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./hosts/framework-13.nix
          nurpkgs.modules.nixos.default
          hardware.nixosModules.framework-13-7040-amd
          # agenix.nixosModules.default
        ];
      };
      "minimal" = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/minimal.nix
          nurpkgs.modules.nixos.default
        ];
      };
      "desktop" = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/desktop.nix
          nurpkgs.modules.nixos.default
        ];
      };
    };

    # Home Manager Configuration.
    homeConfigurations = {
      mia = home-manager.lib.homeManagerConfiguration {
        pkgs = stable;
        extraSpecialArgs = specialArgs;
        modules = [
          ./home.nix # Home-Manager top-level config file
        ];
      };
    };

    # Collection of custom Nix Packages. (No clue how to actually integrate these into my nixpkgs)
    packages = {
      # x86_64-linux.flameshot = stable.callPackage ./src/flameshot.nix {
      #   enableWlrSupport = true;
      # };
      # x86_64-linux.rmatrix =
      #   stable.callPackage ./src/rmatrix.nix {
      #   };
      # x86_64-linux.shell-script =
      #   stable.callPackage ./src/shell-test.nix {
      #   };
      # x86_64-linux.idle-master =
      #   stable.callPackage ./src/idle-master.nix {
      #   };
      x86_64-linux.waybar-timer =
        stable.callPackage ./src/waybar-timer.nix {
        };
    };
  };
}
