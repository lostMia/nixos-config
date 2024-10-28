{
  description = "Mia's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05"; # Stable
    unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable
    nur.url = "github:nix-community/NUR";
    home-manager = { # Home-Manager
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, unstable, nur, home-manager, ...} @ inputs: 
  let
    hostname = "nix";
    stablePkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    unstablePkgs = import unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    specialArgs = {
      inherit inputs self;
      system = "x86_64-linux";
      pkgs = stablePkgs;
    };

  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix             # Main system configuration
        ];
      };
    };

    # homeConfigurations = {
    #   mia = home-manager.lib.homeManagerConfiguration {
    #     pkgs = stablePkgs;
    #     modules = [
    #       ./home.nix  # Home-Manager top-level config file
    #     ];
    #   };
    # };
  };
}
