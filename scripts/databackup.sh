#!/bin/bash
# databackup.sh
# Backs up /home/student/data into versioned folders under /home/student/databackup/
# Scheduled via crontab: every 1 minute

BACKUP_DIR="/home/student/databackup/"
mkdir -p "$BACKUP_DIR"

COUNTER_FILE="$BACKUP_DIR/backup_counter.txt"

if [ ! -f "$COUNTER_FILE" ]; then
    echo "1" > "$COUNTER_FILE"
fi

COUNTER=$(cat "$COUNTER_FILE")
NEW_BACKUP_DIR="$BACKUP_DIR/data_backup_$COUNTER"
mkdir -p "$NEW_BACKUP_DIR"

rsync -a --delete /home/student/data/ "$NEW_BACKUP_DIR/"

COUNTER=$((COUNTER + 1))
echo "$COUNTER" > "$COUNTER_FILE"
