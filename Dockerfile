FROM artemkaint/powerdns:3.4
MAINTAINER artemkaint

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y -q install \
    pdns-backend-mysql pdns-backend-pgsql pdns-backend-sqlite3

ADD powerdns-dock.sh /usr/local/bin

RUN chmod +x /usr/local/bin/powerdns-dock.sh

EXPOSE     53
ENTRYPOINT [ "/usr/local/bin/powerdns-dock.sh" ]
CMD        [ "--no-config", "--master", "--daemon=no", \
             "--local-address=0.0.0.0", \
            "--allow-axfr-ips=${PDNS_AXFR_IPS:-127.0.0.0/8}" ]