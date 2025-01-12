#!/usr/bin/env bash
#
# Ming/Mia's Password Manager Script
#
# Made for usage with the KeePassXC
# password managing utility.
#
# 27.01.2024
#

# Function to display help
function show_help() {
    echo "Usage: $0 [OPTIONS] COMMAND"
    echo "Options:"
    echo "  -h, --help    Show this help message and exit"
    echo "  -v, --version Show the version number and exit"
    echo
    echo "Commands:"
    echo "  connect|c       Connect to database"
    echo "  regenerate|r    Regenerate the Hardware keys"
    echo "  get|g         Get the current config files from the git server"
    echo "  push|p        Push the current changes to the git server"
}

# Connect to database
function connect_db() {
  connect_usb
  kill_keepass
  open_db
  unmount_usb
}

# Regenerate the hardware keys 
function regenerate_hw_keys() {
  connect_usb
  kill_keepass
  regenerate_hw_keys
  unmount_usb
}

function connect_usb() {
  UUID=$UUID_KEY

  # If no UUID for the key is set in the environmental variables, exit the program
  if [ -z $UUID ];
  then
    echo -e "# No UUID_KEY variable value was set"
    exit
  fi

  echo -e -n "$ Looking for USB drive..."
  ls /dev/disk/by-uuid/$UUID &> /dev/null

  if [[ $? == 0 ]];
  then
    echo -e "Done!"
  else
    echo -e "ERROR\n# Couldn't find drive"
    echo -e -n "Trying Backup drive..."

    UUID=$UUID_BACKUP

    # If no UUID for the backup key is set in the environmental variables, exit the program
    if [ -z $UUID ];
    then
      echo -e "# No UUID_BACKUP variable value was set"
      exit
    fi

    ls /dev/disk/by-uuid/$UUID &> /dev/null

    if [[ $? == 0 ]];
    then
      echo -e "Done!"
    else
      echo -e "ERROR\n# Couldn't find drive\n"
      echo -e -n "Trying Backup drive 2..."

      UUID=$UUID_BACKUP2

      # If no UUID for the backup key is set in the environmental variables, exit the program
      if [ -z $UUID ];
      then
        echo -e "# No UUID_BACKUP2 variable value was set"
        exit
      fi

      ls /dev/disk/by-uuid/$UUID &> /dev/null

      if [[ $? == 0 ]];
      then
        echo -e "Done!"
      else
        echo -e "ERROR\n# Couldn't find drive\n"
        exit
      fi
    fi
  fi

  echo -e -n "$ Mounting drive..."
  udisksctl mount -b /dev/disk/by-uuid/$UUID &> /dev/null

  if [[ $? == 0 ]];
  then
    echo -e "Done!"
  else
    echo -e "Already mounted!"
  fi 

  MOUNT=$(findmnt -n -o TARGET -S UUID=$UUID) &> /dev/null

  # Changing to USB Drive Directory
  cd $MOUNT &> /dev/null

  if [[ $? != 0 ]];
  then
    echo -e "# ERROR\n # Can't find or access USB Drive Directory!"
    exit
  fi 
}

function kill_keepass() {
  pkill -f keepassxc-proxy

  # Search for another instance of keepassxc and kill it
  pgrep -x "keepassxc" &> /dev/null

  if [[ $? == 0 ]];
  then
    echo -e -n "$ Killing KeePassXC instance..."
    pkill -f -9 "keepassxc" &> /dev/null
    echo -e "Done!"
  fi
}

function open_db() {
  # Connect to Password Database
  echo -e "$ Connecting to Database"
  keepassxc &> /dev/null

  #echo -e "\e[0;33m"
  #keepassxc ~/Password/.kdbx --keyfile .keyx --pw-stdin 

  if [[ $? != 0 ]];
  then
    echo -e "# ERROR\n# Can't connect to Database!"
  fi 
}

function regenerate_hw_keys() {
  # Regenerate the hardware keys 
  echo -e "$ Regenerating hardware keys"
  echo -e "\e[0;33m"
  mv .keyx .keyx.old
  keepassxc-cli db-edit --key-file .keyx.old $HOME/Password/.kdbx --set-key-file .keyx
 
  if [[ $? != 0 ]];
  then
    echo -e "# ERROR\n# Couldn't change key file for the Database!"
    unmount_usb 
  else
    rm .keyx.old
  fi 
}

function unmount_usb() {
  # Unmount the drive again after keepassxc is closed. 
  echo -e "\e[0;0m"
  echo -e -n "$ Unmounting USB Stick..."
  cd /
  udisksctl unmount -b /dev/disk/by-uuid/$UUID &> /dev/null

  if [[ $? == 0 ]];
  then
    echo -e "Done!"
  else
    echo -e "ERROR\n# Couldn't unmount $UUID!"
    exit
  fi

  echo -e "Goodbye :)"
}

echo -e "\e[1;33m/ᐠ - ˕ -マ\e[0;0m\n"

case "$1" in
    -h|--help)
        show_help
        ;;
    -v|--version)
        echo "Mia's Password Manager Script v1.0"
        ;;
    connect)
        shift
        connect_db
        ;;
    c)
        shift
        connect_db
        ;;
    regenerate)
        shift
        regenerate_hw_keys 
        ;;
    r)
        shift
        regenerate_hw_keys 
        ;;
    *)
        echo "Error: Invalid command. Use --help for usage information."
        exit 1
        ;;
esac


