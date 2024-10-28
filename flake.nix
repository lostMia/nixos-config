{
  description = "Mia's NixOS Flake";

  inputs = {
    stable.url = "github:nixos/nixpkgs/24.05"; # Stable
    unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable
    home-manager.url = "github:nix-community/home-manager"; # Home-Manager
  };

  outputs = { self, stable, unstable, home-manager, ...} @ inputs: 
  let
    stablePkgs = import stable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    unstablePkgs = import unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      nix = { config, pkgs, ... }: {
        pkgs = stablePkgs;
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix # NixOS top-level config file
        ];
      };
    };

    homeConfigurations = {
      mia = home-manager.lib.homeManagerConfiguration {
        pkgs = stablePkgs;
        modules = [
          ./home.nix  # Home-Manager top-level config file
        ];
      };
    };
  };
}
