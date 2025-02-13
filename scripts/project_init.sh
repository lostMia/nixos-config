#!/usr/bin/env bash

if [[ "$1" == "python" || "$1" == "py" ]]; then
  python -m venv venv

  echo "
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    unstablepkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, unstablepkgs }: {
    devShell.x86_64-linux =
      let
        stable = nixpkgs.legacyPackages.x86_64-linux;
        unstable = unstablepkgs.legacyPackages.x86_64-linux;
      in stable.mkShell {
        buildInputs = [
          stable.python312
          stable.python312Packages.numpy
          stable.python312Packages.matplotlib
          unstable.python312Packages.mysql-connector
          # ...
        ];

        shellHook = ''
          source venv/bin/activate
        '';
      };
  };
}" >> flake.nix
elif [[ "$1" == "rust" || "$1" == "rs" ]]; then
    echo "todo lmao"
else
    echo "Usage: $0 {python|rust}"
    exit 1
fi

# .envrc
echo "use flake" >> .envrc

direnv allow
