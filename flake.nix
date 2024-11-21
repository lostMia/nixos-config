{
  description = "Mia's (WIP) NixOS Flake :3";

  # - - - - - - - - - - - - - - - - - - - - - - - - Inputs - - - - - - - - - - - - - - - - - - - - - - - - #

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/release-24.11"; # Stable
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05"; # Stable // Stick to the old channel for now..
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable
    nixpkgs-very-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small"; # Unstable - Small (Living on the edqe....)
    nur.url = "github:nix-community/NUR"; # NUR Repo
    hardware.url = "github:nixos/nixos-hardware"; # NixOS Hardware
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
    unstable = import nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    very-unstable = import nixpkgs-very-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    specialArgs = {
      inherit inputs self unstable;
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
  };
}
