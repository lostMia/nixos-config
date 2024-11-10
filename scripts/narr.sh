#!/usr/bin/env bash

sudo protonvpn disconnect
notify-send 'Disconnected! Welcome back!' -u low
pkill python3

exit
