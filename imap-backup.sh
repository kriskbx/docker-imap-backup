#!/bin/sh

echo "[$(date)] Starting imap backup…"
/usr/local/bundle/bin/imap-backup
echo "[$(date)] Backup finished!"
