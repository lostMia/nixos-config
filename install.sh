#!/run/current-system/sw/bin/bash

# Don't forget to pull the LFS file...
# git lfs pull

# Store Packet Tracer in /nix/store
nix-store --add-fixed sha256 ./resources/CiscoPacketTracer822_amd64_signed.deb

# Rebuild the system
sudo nixos-rebuild switch --flake . --impure

# Home-Manager
nix build .#homeConfigurations.mia.activationPackage
./result/activate
home-manager switch --flake .
