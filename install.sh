#!/run/current-system/sw/bin/bash

sudo nix-store --add-fixed sha256 ./resources/CiscoPacketTracer822_amd64_signed.deb

sudo nixos-rebuild switch --flake . --impure
home-manager switch --flake .
