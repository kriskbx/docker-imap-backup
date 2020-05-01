FROM ruby:2.3-alpine

# install gem
RUN gem install 'imap-backup'

# add cron log
RUN touch /var/log/cron.log

# add entrypoint script
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod a+x /usr/local/bin/entrypoint.sh

# add imap backup script
ADD imap-backup.sh /usr/local/bin/imap-backup.sh
RUN chmod a+x /usr/local/bin/imap-backup.sh

# mount this, if you want to store the config in a volume
VOLUME /root/.imap-backup

ENTRYPOINT ["entrypoint.sh"]
CMD ["crond","-f", "-L", "/dev/stdout"]
