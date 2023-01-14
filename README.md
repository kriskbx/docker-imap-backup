# docker imap backup 

> Simple Docker image that runs imap-backup with crontab.

## How to use

Checkout the documentation at [joeyates/imap-backup](https://github.com/joeyates/imap-backup#configuration-file) and create a config.json configuration file.

Pass the configuration into the container via a environment variable:

```bash
docker run \
    -e 'CONFIG={"accounts":[]}' \
    kriskbx/docker-imap-backup
```

… or via volume (might only work on linux because file systems and permissions 🤷):

```bash
docker run \
    -v /host/path/to/config.json:/root/.imap-backup/config.json:ro \
    kriskbx/docker-imap-backup
```

Make sure you mount the directories your emails will be backuped to as volumes as well.

If you want to change the default hourly interval, pass an environment variable:

```bash
docker run \
    -e 'SCHEDULE=* * * * *' \
    kriskbx/docker-imap-backup
```

If you want to schedule the job from your host/orchestrator, set the command to use the backup script:

```bash
docker run kriskbx/docker-imap-backup /usr/local/bin/imap-backup.sh
```

## License

MIT
