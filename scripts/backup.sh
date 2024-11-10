#!/usr/bin/env bash

notify-send "Backup in progress..." -w -t 5 --icon=/home/mia/.config/dunst/images/backup.png

# Directories to backup
BACKUP_DIRS=(
    "/home/mia")

udisksctl mount -b /dev/disk/by-uuid/e3934e46-fb1f-48d8-ba60-5684e99186d8 

# Destination for backups (change to your preferred backup location)
BACKUP_DEST="/run/media/mia/e3934e46-fb1f-48d8-ba60-5684e99186d8"

# Date format for timestamped backup files
DATE=$(date +'%Y-%m-%d_%H-%M-%S')

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DEST"

# Loop through each directory and create a tar.gz backup
for DIR in "${BACKUP_DIRS[@]}"; do
    # Remove slashes from directory names for filename
    DIR_NAME=$(basename "$DIR")
    TAR_FILE="${BACKUP_DEST}/${DIR_NAME}_backup_${DATE}.tar.gz"
    
    sudo tar -czf "$TAR_FILE" "$DIR"
done

udisksctl unmount -b /dev/disk/by-uuid/e3934e46-fb1f-48d8-ba60-5684e99186d8

notify-send "Backup Done!" -w -t 0 --icon=/home/mia/.config/dunst/images/backup.png
