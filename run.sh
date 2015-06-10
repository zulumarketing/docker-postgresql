#!/bin/bash

function shutdown {
    echo "Shutting down PostgreSQL"
    pkill postgres
}

if [ -d /var/run/postgresql ]; then
    chmod 2775 /var/run/postgresql
else
    install -d -m 2775 -o postgres -g postgres /var/run/postgresql
fi

trap shutdown HUP INT QUIT ABRT KILL ALRM TERM TSTP

exec sudo -u postgres /usr/lib/postgresql/9.3/bin/postgres \
                      -D /var/lib/postgresql/9.3/main \
                      --config-file=/etc/postgresql/9.3/main/postgresql.conf
