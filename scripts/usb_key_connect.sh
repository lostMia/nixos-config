#!/usr/bin/env bash

UUID_KEY="0D15-EA5E"
UUID_BACKUP="1D15-EA5E"
UUID_BACKUP2="2D15-EA5E"

function connect_usb() {
  UUID=$UUID_KEY

  # If no UUID for the key is set in the environmental variables, exit the program
  if [ -z $UUID ];
  then
    echo -e "# No UUID_KEY variable value was set" >> /home/mia/Scripts/log
    exit
  fi

  echo -e -n "$ Looking for USB drive..." >> /home/mia/Scripts/log
  ls /dev/disk/by-uuid/$UUID >> /home/mia/Scripts/log

  if [[ $? == 0 ]];
  then
    echo -e "Done!" >> /home/mia/Scripts/log
  else
    echo -e "ERROR\n# Couldn't find drive" >> /home/mia/Scripts/log
    echo -e -n "Trying Backup drive..." >> /home/mia/Scripts/log

    UUID=$UUID_BACKUP

    # If no UUID for the backup key is set in the environmental variables, exit the program
    if [ -z $UUID ];
    then
      echo -e "# No UUID_BACKUP variable value was set" >> /home/mia/Scripts/log
      exit
    fi

    ls /dev/disk/by-uuid/1D15-EA5E >> /home/mia/Scripts/log

    if [[ $? == 0 ]];
    then
      echo -e "Done!" >> /home/mia/Scripts/log
    else
      echo -e "ERROR\n# Couldn't find drive\n" >> /home/mia/Scripts/log
      echo -e -n "Trying Backup drive 2..." >> /home/mia/Scripts/log

      UUID=$UUID_BACKUP2

      # If no UUID for the backup key is set in the environmental variables, exit the program
      if [ -z $UUID ];
      then
        echo -e "# No UUID_BACKUP2 variable value was set" >> /home/mia/Scripts/log
        exit
      fi

      ls /dev/disk/by-uuid/$UUID  >> /home/mia/Scripts/log

      if [[ $? == 0 ]];
      then
        echo -e "Done!" >> /home/mia/Scripts/log
      else
        echo -e "ERROR\n# Couldn't find drive\n" >> /home/mia/Scripts/log
        exit
      fi
    fi
  fi

  echo -e -n "$ Mounting drive..." >> /home/mia/Scripts/log
  udisksctl mount -b /dev/disk/by-uuid/$UUID &> /dev/null

  if [[ $? == 0 ]];
  then
    echo -e "Done!" >> /home/mia/Scripts/log
  else
    echo -e "Already mounted!" >> /home/mia/Scripts/log
  fi 

  MOUNT=$(findmnt -n -o TARGET -S UUID=$UUID) &> /dev/null

  # Changing to USB Drive Directory
  cd $MOUNT &> /dev/null

  if [[ $? != 0 ]];
  then
    echo -e "# ERROR\n # Can't find or access USB Drive Directory!" >> /home/mia/Scripts/log
    exit
  fi 
}

function unmount_usb() {
  # Unmount the drive again after keepassxc is closed. 
  echo -e "\e[0;0m" >> /home/mia/Scripts/log
  echo -e -n "$ Unmounting USB Stick..." >> /home/mia/Scripts/log
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

connect_usb

cp .keyx /tmp/
notify-send 'Password loaded!' -u normal

unmount_usb
