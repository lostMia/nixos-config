#!/usr/bin/env bash

set -e
pushd ~/.config/nixos/

# make changes
nvim configuration.nix
alejandra . &>/dev/null

echo -e "\n\e[1m - - - - - - - - Changes - - - - - - - -\e[0m\n"

# show changes
git diff -U0 *.nix

echo -e "\n\e[1m - - - - - - - Rebuilding - - - - - - -\e[0m\n"

# rebuild
echo "NixOS Rebuilding..."
#sudo nixos-rebuild switch &>nixos-switch.log || (
# cat nixos-switch.log | grep --color error && false)

sudo nixos-rebuild switch --flake /home/mia/.config/nixos
notify-send "Build done!" -u low --icon=/home/mia/.config/dunst/images/nixos.png


echo -e "\n\e[1m - - - - - - - - Commit - - - - - - - -\e[0m\n"

# git
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
git push

echo -e "\n\e[1m - - - - - Generation Cleanup - - - - -\e[0m\n"

# clean up old nixos generations
sudo bash /home/mia/Scripts/trim_generations.sh 10 15 system
# clean up old home-manager generations
home-manager expire-generations "-15 days"

popd
