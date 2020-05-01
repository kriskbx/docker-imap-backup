#!/bin/sh

echo "[$(date)] Starting imap backup…"
imap-backup
echo "[$(date)] Backup finished!"
