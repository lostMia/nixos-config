#!/usr/bin/env bash

monitor_brightness=$(brightnessctl get)
keyboard_brightness=$(brightnessctl -d framework_laptop::kbd_backlight get)
current_workspace=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name')

swaymsg workspace 0
pkill waybar
brightnessctl set 255
swaymsg output eDP-1 background \#ffffff solid_color
brightnessctl -d framework_laptop::kbd_backlight set 255

sleep 1.5

swaymsg output eDP-1 bg $HOME/.config/nixos/resources/nix.png fill
brightnessctl set $monitor_brightness
brightnessctl -d framework_laptop::kbd_backlight set $keyboard_brightness
swaymsg workspace $current_workspace
waybar & disown
