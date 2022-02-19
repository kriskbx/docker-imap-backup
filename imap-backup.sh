#!/bin/sh

echo "[$(date)] Starting imap backup…"
export GEM_HOME=/usr/local/bundle
/usr/local/bundle/bin/imap-backup
echo "[$(date)] Backup finished!"