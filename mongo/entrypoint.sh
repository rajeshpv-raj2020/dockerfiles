#!/usr/bin/env bash

# /setTimeZone.sh

if [[ -z "$@" ]]; then
    # echo "Starting NO args"
    touch /var/log/mongodb/mongod.log
    nohup /usr/bin/mongod --bind_ip 0.0.0.0 --config /etc/mongod.conf > mongod.out 2>&1 &
    tail -f /var/log/mongodb/mongod.log
else
    # echo "Starting WITH args"
    exec "$@"
fi
