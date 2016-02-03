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
    shift # past argument=value
    ;;
    --gpgsql-port=*)
    PORT="${i#*=}"
    shift # past argument=value
    ;;
    --gpgsql-dbname=*)
    DB="${i#*=}"
    shift # past argument=value
    ;;
    --gpgsql-user=*)
    USER="${i#*=}"
    shift # past argument=value
    ;;
    --gpgsql-password=*)
    PASSWORD="${i#*=}"
    shift # past argument=value
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
