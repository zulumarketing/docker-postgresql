#!/bin/bash

if [[ !-d /var/lib/postgresql/9.3/main ]]; then
    pg_createcluster 9.3 main
fi

exec /usr/lib/postgresql/9.3/bin/postgres "$@"
