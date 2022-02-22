FROM debian:bullseye-slim


# install other dependencies
RUN apt-get update && apt-get install -y && apt-get install -y \
    mariadb-client \ 
    cron 

COPY tools/clean-db-cron /etc/cron.d/clean-db-cron
COPY tools/privacy_clean_db.sql /privacy_clean_db.sql

RUN chmod 0644 /etc/cron.d/clean-db-cron && \
  crontab /etc/cron.d/clean-db-cron && \
  touch /var/log/cron.log

CMD ["cron", "-f"]
#ENTRYPOINT ["bash", "/init.sh"])
