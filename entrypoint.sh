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
echo "Setting Crontab:"
echo "$SCHEDULE ($BACKUP_SCRIPT) > /root/.imap-backup/imap-backup.log 2>&1"
echo "$SCHEDULE ($BACKUP_SCRIPT) > /root/.imap-backup/imap-backup.log 2>&1" | crontab -
echo "Starting cron service..."
service cron start

# run backup script once at startup
echo "Starting initial Backup..."
echo "Depending on your mail account this can take several minutes..."
.$BACKUP_SCRIPT
echo "Initial Backup finished"

# follow the imap backup log file to keep the container healthy
touch /root/.imap-backup/imap-backup.log
echo "Following the logfile and waiting for next cron execution..."
echo "------------------------------------------------------------"
tail -f /root/.imap-backup/imap-backup.log
