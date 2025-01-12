flameshot gui -r | wl-copy

# old one using satty instead of flameshot
# grim -g "$(slurp -c '#ff0000ff')" -t ppm - | satty --filename - --copy-command=wl-copy --early-exit
