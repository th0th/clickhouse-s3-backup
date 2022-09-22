`clickhouse-s3-backup` is a docker image to backup data from a ClickHouse database to AWS S3.

## Usage

### Environment variables

| Variable              | Required | Default value  | Description                                                                                                           |
|-----------------------|:--------:|----------------|-----------------------------------------------------------------------------------------------------------------------|
| AWS_ACCESS_KEY_ID     | ✔        |                | Access key id for the AWS account                                                                                     |
| AWS_REGION            | ✔        |                | Region for the AWS bucket                                                                                             |
| AWS_S3_ENDPOINT       | ✔        |                | AWS S3 endpoint with bucket and path (e.g. "my-bucket/postgres-backup")                                               |
| AWS_SECRET_ACCESS_KEY | ✔        |                | Secret access key for the AWS account                                                                                 |
| CLICKHOUSE_DATABASE   |          | default        | ClickHouse server database                                                                                            |
| CLICKHOUSE_HOST       |          | clickhouse     | ClickHouse server host                                                                                                |
| CLICKHOUSE_PASSWORD   |          |                | ClickHouse server password                                                                                            |
| CLICKHOUSE_PORT       |          | 9000           | ClickHouse server port                                                                                                |
| CLICKHOUSE_QUERY      | ✔        |                | ClickHouse query to get the data                                                                                      |
| CLICKHOUSE_USER       |          | default        | ClickHouse server user                                                                                                |
| FILE_NAME             |          | %F_%T          | Name of the file for the data export (it can include [date format](https://man7.org/linux/man-pages/man1/date.1.html)) |
| WEBGAZER_PULSE_URL    |          |                | [WebGazer Pulse](https://www.webgazer.io/pulse) URL                                                                   |
             
### Running

    $ docker run th0th/clickhouse-s3-backup \
        -e AWS_ACCESS_KEY_ID=<aws_access_key_id> \
        -e AWS_REGION=<aws_region> \
        -e AWS_S3_ENDPOINT=<aws_s3_endpoint> \
        -e AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> \
        -e CLICKHOUSE_DATABASE=<clickhouse_database[default]> \
        -e CLICKHOUSE_HOST=<clickhouse_host[clickhouse]> \
        -e CLICKHOUSE_PASSWORD=<clickhouse_password[n/a]> \
        -e CLICKHOUSE_PORT=<clickhouse_port[9000]> \
        -e CLICKHOUSE_QUERY=<clickhouse_query> \
        -e CLICKHOUSE_USER=<clickhouse_user[clickhouse]> \
        -e FILE_NAME=<file_name> \
        -e WEBGAZER_PULSE_URL=<webgazer_pulse_url>

### Example

    $ docker run th0th/postgres-s3 \
        -e AWS_ACCESS_KEY_ID=g9XqNnqKmUk6xqwkStkN \
        -e AWS_REGION=eu-west-1 \
        -e AWS_SECRET_ACCESS_KEY=GLBZ8mQf27UL57YHbkLhXWtfJWVwtUBbQup6mFzw \
        -e AWS_S3_ENDPOINT=my-bucket/path \
        -e CLICKHOUSE_DATABASE=events \
        -e CLICKHOUSE_HOST=clickhouse-server \
        -e CLICKHOUSE_PASSWORD=wcjj8CioEpqaY2VY \
        -e CLICKHOUSE_QUERY="select * from table1" \
        -e CLICKHOUSE_USER=clickhouse_user
        -e FILE_NAME="table1_backup-%F_%T" \
        -e WEBGAZER_PULSE_URL=https://pulse.webgazer.io/1-8f713c75d659

## Shameless plug

I am an indie hacker, and I am running two services that might be useful for your business. Check them out :)

### WebGazer

[<img alt="WebGazer" src="https://user-images.githubusercontent.com/698079/162474223-f7e819c4-4421-4715-b8a2-819583550036.png" width="256" />](https://www.webgazer.io/?utm_source=github&utm_campaign=clickhouse-s3-backup-readme)

[WebGazer](https://www.webgazer.io/?utm_source=github&utm_campaign=clickhouse-s3-backup-readme) is a monitoring service that checks your website, cron jobs, or scheduled tasks on a regular basis. It notifies
you with instant alerts in case of a problem. That way, you have peace of mind about the status of your service without
manually checking it.

### PoeticMetric

[<img alt="PoeticMetric" src="https://user-images.githubusercontent.com/698079/162474946-7c4565ba-5097-4a42-8821-d087e6f56a5d.png" width="256" />](https://www.poeticmetric.com/?utm_source=github&utm_campaign=clickhouse-s3-backup-readme)

[PoeticMetric](https://www.poeticmetric.com/?utm_source=github&utm_campaign=clickhouse-s3-backup-readme) is a privacy-first, regulation-compliant, blazingly fast analytics tool.

No cookies or personal data collection. So you don't have to worry about cookie banners or GDPR, CCPA, and PECR compliance.

## License

Copyright © 2022, Gokhan Sari. Released under the [MIT License](LICENSE).
