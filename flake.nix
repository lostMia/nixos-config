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
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11"; # Stable
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # Unstable
    nixpkgs-very-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small"; # Unstable - Small (Living on the edqe....)
    nur.url = "github:nix-community/NUR"; # NUR Repo
    hardware.url = "github:NixOS/nixos-hardware"; # NixOS Hardware
    home-manager = {
      # Home-Manager
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # - - - - - - - - - - - - - - - - - - - - - - - - Outputs - - - - - - - - - - - - - - - - - - - - - - - #

  outputs = {
    self,
    nixpkgs,
    nixpkgs-old,
    nixpkgs-unstable,
    nixpkgs-very-unstable,
    nur,
    hardware,
    home-manager,
    ...
  } @ inputs: let
    hostname = "nix";

    stable = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    old = import nixpkgs-old {
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

    specialArgs = {
      inherit inputs self unstable very-unstable;
      system = "x86_64-linux";
      pkgs = stable;
    };
  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./configuration.nix # NixOS top-level config file
          nur.nixosModules.nur
          hardware.nixosModules.framework-13-7040-amd
        ];
      };
    };

    homeConfigurations = {
      mia = home-manager.lib.homeManagerConfiguration {
        pkgs = stable;
        modules = [
          ./home.nix # Home-Manager top-level config file
        ];
      };
    };

    packages = {
      flameshot = stable.callPackage ./src/flameshot.nix {};
    };
  };
}
