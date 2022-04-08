#!/usr/bin/env bash

set -eo pipefail

# required environment variables
: "${AWS_ACCESS_KEY_ID:?Please set the environment variable.}"
: "${AWS_REGION:?Please set the environment variable.}"
: "${AWS_S3_ENDPOINT:?Please set the environment variable.}"
: "${AWS_SECRET_ACCESS_KEY:?Please set the environment variable.}"
: "${CLICKHOUSE_HOST:?Please set the environment variable.}"
: "${CLICKHOUSE_QUERY:?Please set the environment variable.}"
: "${CLICKHOUSE_PASSWORD:?Please set the environment variable.}"

# optional environment variables with defaults
BACKUP_FILE_NAME="${BACKUP_FILE_NAME:-"%F_%T"}"
CLICKHOUSE_PORT="${CLICKHOUSE_PORT:-9000}"
CLICKHOUSE_USER="${CLICKHOUSE_USER:-clickhouse}"

# logic starts here
BACKUP_DATED_FILE_NAME=$(date +"${BACKUP_FILE_NAME}")
BACKUP_FILE_CSV_NAME="${BACKUP_DATED_FILE_NAME}.csv"
BACKUP_FILE_GZ_NAME="${BACKUP_DATED_FILE_NAME}.csv.gz"

echo "Exporting the results for the query..."
clickhouse-client \
  --user $CLICKHOUSE_USER \
  --password "${CLICKHOUSE_PASSWORD}" \
  --query "${CLICKHOUSE_QUERY}" \
  --format CSV > "${BACKUP_FILE_CSV_NAME}"
echo "Exporting the results for the query... Done."

echo "Compressing..."
gzip -c "${BACKUP_FILE_CSV_NAME}" > "${BACKUP_FILE_GZ_NAME}"
echo "Compressing... Done."

echo "Uploading to S3..."
rclone copyto \
  --s3-no-check-bucket \
  "./${BACKUP_FILE_GZ_NAME}" \
  ":s3,access_key_id=${AWS_ACCESS_KEY_ID},region=${AWS_REGION},secret_access_key=${AWS_SECRET_ACCESS_KEY}:${AWS_S3_ENDPOINT}/${BACKUP_FILE_GZ_NAME}"
echo "Uploading to S3... Done."
