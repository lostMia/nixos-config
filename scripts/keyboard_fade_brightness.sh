#!/usr/bin/env bash

# Check for correct number of arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <start> <end> [sleep_duration]"
    exit 1
fi

# Parameters
START=$1
END=$2
SLEEP_DURATION="${3:-0.5}"  # Default sleep duration is 0.5 seconds if not provided

# Determine the step based on the direction (decreasing or increasing)
if [ "$START" -gt "$END" ]; then
    STEP=-1
else
    STEP=1
fi

# Loop from START to END
for ((brightness=START; brightness != END + STEP; brightness+=STEP)); do
    brightnessctl -d framework_laptop::kbd_backlight set "$brightness"
    sleep "$SLEEP_DURATION"
done
