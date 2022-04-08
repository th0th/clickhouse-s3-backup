`clickhouse-s3-backup` is a docker image that helps backing up clickhouse data dump to AWS S3.

# Usage

    $ docker run th0th/clickhouse-s3-backup \
        -e AWS_ACCESS_KEY_ID=<aws_access_key_id> \
        -e AWS_REGION=<aws_region> \
        -e AWS_S3_ENDPOINT=<aws_s3_endpoint> \
        -e AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> \
        -e CLICKHOUSE_HOST=<clickhouse_host[clickhouse]> \
        -e CLICKHOUSE_QUERY=<clickhouse_query> \
        -e CLICKHOUSE_PASSWORD=<clickhouse_password> \
        -e CLICKHOUSE_PORT=<clickhouse_port[9000]> \
        -e CLICKHOUSE_USER=<clickhouse_user>

## Environment variables

| Variable                 | Required | Default value | Description                                                                                                                   |
| ------------------------ | -------- | ------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| AWS\_ACCESS\_KEY\_ID     | ✅        |               | Access key id for the AWS account                                                                                             |
| AWS\_REGION              | ✅        |               | Region for the AWS bucket                                                                                                     |
| AWS\_S3\_ENDPOINT        | ✅        |               | AWS S3 endpoint with bucket and path (e.g. "my-bucket/clickhouse-backup")                                                     |
| AWS\_SECRET\_ACCESS\_KEY | ✅        |               | Secret access key for the AWS account                                                                                         |
| BACKUP\_FILE\_NAME       |          | %F\_%T        | File name for the backup file (support date format) (e.g. clickhouse-backup-%F\_%T)                                           |
| CLICKHOUSE\_HOST         | ✅        |               | Clickhouse server host (e.g. [clickhouse.mydomain.com](http://clickhouse.mydomain.com/))                                      |
| CLICKHOUSE\_PASSWORD     | ✅        |               | Clickhouse server password                                                                                                    |
| CLICKHOUSE\_PORT         |          | 9000          | Clickhouse server port                                                                                                        |
| CLICKHOUSE\_QUERY        | ✅        |               | The query that will get the data to be backed up (e.g. "select \* from service\_logs where date\_time > toStartOfDay(now())") |
| CLICKHOUSE\_USER         |          | clickhouse    | Clickhouse server user name                                                                                                   |


## Example

    $ docker run th0th/postgres-s3 \
        -e POSTGRES_HOST=database \
        -e POSTGRES_PORT=5432 \
        -e POSTGRES_USER=db_user \
        -e POSTGRES_PASSWORD=db_password \
        -e POSTGRES_DB=database \
        -e AWS_ACCESS_KEY_ID=g9XqNnqKmUk6xqwkStkN \
        -e AWS_SECRET_ACCESS_KEY=GLBZ8mQf27UL57YHbkLhXWtfJWVwtUBbQup6mFzw \
        -e AWS_S3_ENDPOINT=my-bucket/path
