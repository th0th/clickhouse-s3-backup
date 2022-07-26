#!/usr/bin/env bash

set -eo pipefail

SECONDS=0

# required environment variables
: "${AWS_ACCESS_KEY_ID:?Please set the environment variable.}"
: "${AWS_REGION:?Please set the environment variable.}"
: "${AWS_S3_ENDPOINT:?Please set the environment variable.}"
: "${AWS_SECRET_ACCESS_KEY:?Please set the environment variable.}"
: "${CLICKHOUSE_HOST:?Please set the environment variable.}"
: "${CLICKHOUSE_QUERY:?Please set the environment variable.}"

# optional environment variables with defaults
FILE_NAME="${FILE_NAME:-"%F_%T"}"
CLICKHOUSE_HOST="${CLICKHOUSE_HOST:-clickhouse}"
CLICKHOUSE_PORT="${CLICKHOUSE_PORT:-9000}"

# logic starts here
DATED_FILE_NAME=$(date +"${FILE_NAME}")
DATED_FILE_NAME_GZ="${DATED_FILE_NAME}.gz"

echo "Exporting the results for the query..."
clickhouse-client \
  --host "${CLICKHOUSE_HOST}" \
  --port "${CLICKHOUSE_PORT}" \
  --query "${CLICKHOUSE_QUERY}" \
  --format Native | pigz --fast > "${DATED_FILE_NAME_GZ}"
echo "Exporting the results for the query... Done."

echo "Uploading to S3..."
rclone copyto \
  --s3-no-check-bucket \
  "./${BACKUP_FILE_GZ_NAME}" \
  ":s3,access_key_id=${AWS_ACCESS_KEY_ID},region=${AWS_REGION},secret_access_key=${AWS_SECRET_ACCESS_KEY},storage_class=GLACIER:${AWS_S3_ENDPOINT}/${DATED_FILE_NAME_GZ}"
echo "Uploading to S3... Done."

if [ -n "${WEBGAZER_PULSE_URL}" ]; then
  curl "${WEBGAZER_PULSE_URL}?seconds=${SECONDS}"
fi