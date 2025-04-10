#!/usr/bin/env bash

# Directory to watch
directory=/home/mia/Documents/Matteo/
# Place to store the latest hash value
last_hash_location=/home/mia/Documents/Mia/last.hash

INTERVAL=30 # The interval in seconds at which to check the folder 

while true;
do
  sleep $INTERVAL

  get_current_hash () {
    # Probably better to just hash it ourselves instead of relying on git, since we
    # still want to get notifications for non-commited changes!
    # echo $(git log -p -1 | head -n 1 | cut -d " " -f 2)
    echo $(sha256sum $directory/* | sha256sum)
  }


  if ! [ -e $last_hash_location ]; then
    touch $last_hash_location
    get_current_hash > $last_hash_location
    continue
  fi

  last_hash=$(cat $last_hash_location)
  current_hash=$(get_current_hash)

  # If there was a change and the directory hash has changed, notify the user. 
  if [ "$last_hash" != "$current_hash" ]; then
    notify-send "New Data in $directory!" -t 0
    echo $current_hash > $last_hash_location
  fi
done
