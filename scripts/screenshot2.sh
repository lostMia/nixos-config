#/usr/bin/env bash

geometry=$(slurp -c "#ff0000ff")

if [[ "$?" != "0" ]]
then
  pkill wayfreeze || true
  exit
fi

grim -g "$geometry" -t ppm - | satty --filename - --copy-command=wl-copy --early-exit &

pkill wayfreeze || true
