FROM ruby:3.2-buster

# install cron & certificates
RUN apt-get update \
    && apt-get install -y \
        cron \
        ca-certificates \
    && rm -rf /etc/cron.*/*

# install gem
RUN whoami && gem install 'imap-backup' && which imap-backup

# add entrypoint script
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod a+x /usr/local/bin/entrypoint.sh

# add imap backup script
ADD imap-backup.sh /usr/local/bin/imap-backup.sh
RUN chmod a+x /usr/local/bin/imap-backup.sh

# mount this, if you want to store the config in a volume
VOLUME /root/.imap-backup

ENTRYPOINT ["entrypoint.sh"]
CMD ["cron", "-f"]
