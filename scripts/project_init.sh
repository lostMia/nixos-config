#!/usr/bin/env bash

if [[ "$1" == "python" || "$1" == "py" ]]; then
  python -m venv venv

  # maybe change this to make a flake instead in the future?
  echo "
  { pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

  pkgs.mkShell {
    packages = [
      pkgs.python312Packages.numpy
      pkgs.python312Packages.matplotlib
      pkgs.python312Packages.mysql-connector
      # ...
    ];

    shellHook = ''
      source venv/bin/activate
    '';
  }
  " >> shell.nix
elif [[ "$1" == "rust" || "$1" == "rs" ]]; then
    echo "todo lmao"
else
    echo "Usage: $0 {python|rust}"
    exit 1
fi

# .envrc
echo "use nix" >> .envrc

direnv allow
