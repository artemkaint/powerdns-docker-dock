#!/bin/bash

HOST="127.0.0.1"
PORT=5432
USER="root"
PASSWORD=""
DB="root"

for i in "$@"
do
case $i in
    --gpgsql-host=*)
    HOST="${i#*=}"
    ;;
    --gpgsql-port=*)
    PORT="${i#*=}"
    ;;
    --gpgsql-dbname=*)
    DB="${i#*=}"
    ;;
    --gpgsql-user=*)
    USER="${i#*=}"
    ;;
    --gpgsql-password=*)
    PASSWORD="${i#*=}"
    ;;
    *)
    ;;
esac
done

export PGPASSWORD=$PASSWORD
psql -h $HOST \
     -p $PORT \
     -d $USER \
     -U $DB \
     -f /usr/share/doc/pdns-backend-pgsql/schema.pgsql.sql

/usr/sbin/pdns_server $@
