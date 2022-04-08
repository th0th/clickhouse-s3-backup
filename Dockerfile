FROM clickhouse/clickhouse-client:latest

WORKDIR /root

RUN apk update && \
    apk add bash rclone

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
