#!/bin/sh
set -e

CONFIG_FILE=/root/.imap-backup/config.json
BACKUP_SCRIPT=/usr/local/bin/imap-backup.sh

CONFIG=${CONFIG:-'{"accounts":[]}'}
SCHEDULE=${SCHEDULE:-"0 * * * *"}

# create config file if it doesn't exist
if [ ! -f $CONFIG_FILE ]; then
    echo "[$(date)] Creating config file…"

    echo $CONFIG >> $CONFIG_FILE
    chmod 0600 $CONFIG_FILE
fi

# add backup script to crontab
echo "$SCHEDULE root $BACKUP_SCRIPT > /proc/1/fd/1 2>/proc/1/fd/2" > /etc/crontab

# set environment
env >> /etc/environment

exec "$@"
