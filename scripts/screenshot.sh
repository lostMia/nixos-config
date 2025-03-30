#!/run/current-system/sw/bin/bash

# flameshot gui -r | wl-copy

# old one using satty instead of flameshot
# grim -g "$(slurp -c '#ff0000ff')" -t ppm - | satty --filename - --copy-command=wl-copy --early-exit
hyprpicker -r -z &

geometry=$(slurp -c '#ff0000ff')

if [[ "$?" != "0" ]]
then
  pkill hyprpicker || true
  exit
fi


grim -g "$geometry" -t ppm - | satty --filename - --copy-command=wl-copy --early-exit &

pkill hyprpicker || true
