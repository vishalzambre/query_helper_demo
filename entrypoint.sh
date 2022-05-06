#!/usr/bin/env bash
set -e

printenv | sed 's/^\(.*\)$/export \1/g' >/env.sh

# set up /etc/odbc.ini for snowflake connection
cat <<EOF >/etc/odbc.ini
[ODBC Data Sources]
PredictDbAds = SnowflakeDSIIDriver

[PredictDbAds]
Driver          = SnowflakeDSIIDriver
Locale          = en-US;
uid             = ${SNOWFLAKE_USER}
pwd             = ${SNOWFLAKE_PASSWORD}
server          = ${SNOWFLAKE_ACCOUNT}.snowflakecomputing.com
role            = ${SNOWFLAKE_ROLE}
warehouse       = ${SNOWFLAKE_WAREHOUSE}
database        = PREDICT_DB
schema          = ${SNOWFLAKE_SCHEMA}
EOF

if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

exec "$@"

