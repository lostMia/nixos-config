#!/usr/bin/env bash

PACKAGE_NAME="temp"

if [[ "$1" == "python" || "$1" == "py" ]]; then
  python -m venv .venv

  echo "
{
  inputs = {
    nixpkgs.url = \"github:nixos/nixpkgs/release-25.05\";
    unstablepkgs.url = \"github:NixOS/nixpkgs/nixos-unstable\";
  };

  outputs = { self, nixpkgs, unstablepkgs }: {
    devShell.x86_64-linux =
      let
        stable = import nixpkgs {
          system = \"x86_64-linux\";
          config = {
            allowUnfree = true;
          };
        };

        unstable = import unstablepkgs {
          system = \"x86_64-linux\";
          config = {
            allowUnfree = true;
          };
        };
      in stable.mkShell {
        buildInputs = [
          stable.python313
          stable.python313Packages.venvShellHook
          stable.python313Packages.numpy
          stable.python313Packages.python-dotenv
          # ...
        ];

        shellHook = ''
          if [ ! -d .venv ]; then
            python -m venv .venv
            source .venv/bin/activate
            pip install --upgrade pip setuptools wheel
            # pip install [regular pip package(s)] 
          else
            source .venv/bin/activate
          fi
        '';
      };
  };
}" >> flake.nix
elif [[ "$1" == "rust" || "$1" == "rs" ]]; then
  if [ -n "$2" ]; then
    PACKAGE_NAME=$2
  fi

  nix run nixpkgs#cargo init $PACKAGE_NAME 
  cd $PACKAGE_NAME
  nix run nixpkgs#cargo update

  # Package 
  echo "
{ 
  pkgs ? import <nixpkgs> { } 
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = \""$PACKAGE_NAME"\";
  version = "0.1";
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
}" >> default.nix

  # Flake
  echo " 
{
  description = \""$PACKAGE_NAME"\";
  inputs = {
    nixpkgs.url = \"github:nixos/nixpkgs/nixos-unstable\";
    unstablepkgs.url = \"github:NixOS/nixpkgs/nixos-unstable\";
  };
  outputs = { self, nixpkgs, unstablepkgs }:
    let
      stable = nixpkgs.legacyPackages.x86_64-linux;
      unstable = unstablepkgs.legacyPackages.x86_64-linux;
      supportedSystems = [ \"x86_64-linux\" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = nixpkgs.legacyPackages;
    in {
      packages = forAllSystems (system: {
        default = pkgsFor.${system}.callPackage ./. { };
      });
    };
}" >> flake.nix
else
    echo "Usage: $0 {python|rust} [Project name]"
    exit 1
fi

git init
git add .

# .envrc
echo "use flake" >> .envrc
direnv allow
