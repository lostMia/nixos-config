#!/usr/bin/env bash

sudo nix-collect-garbage -d 
nix-collect-garbage -d 
sudo nix-store --optimise
cd /home/mia/.config/nixos/
nix store gc
nix store optimise
