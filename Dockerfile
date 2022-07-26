FROM clickhouse/clickhouse-server:latest-alpine

WORKDIR /root

RUN apk update && \
    apk add bash curl pigz rclone

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
