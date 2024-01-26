#!/bin/sh

# Backup directory path
SAVE_DIR="/home/steam/Steam/steamapps/common/PalServer/Pal/Saved/SaveGames/0/9A7D1CF9D1074112BE5FD5037859A335"
BACKUP_DIR="$SAVE_DIR/backup"
LOG_FILE="/home/steam/logs/backup.log"
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
BACKUP_FILE=$(date '+%Y-%m-%d-%H-%M-%S')$1.tar.gz

# Backup files
cd $SAVE_DIR && mkdir -p ./backup && tar -czvf ./backup/$BACKUP_FILE ./Level.sav ./LevelMeta.sav ./Players/*
echo "$CURRENT_TIME: Created backup file $BACKUP_FILE" >> $LOG_FILE

# Delete backups older than 3 days and log the action
find "$BACKUP_DIR" -type f -mtime +3 -exec rm {} \; -exec echo "$CURRENT_TIME: Deleted backup file {}" >> $LOG_FILE \;

