#!/usr/bin/env bash

sudo systemctl start NetworkManager
protonvpn-applet & disown
sudo protonvpn connect --cc US
notify-send 'Connected! Have fun :)'

exit
