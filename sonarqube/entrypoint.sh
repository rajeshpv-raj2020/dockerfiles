#!/usr/bin/env bash

/setTimeZone.sh
## tail -f /sonarqube/bin/run.sh

if [[ -z "$@" ]]; then
    # echo "Starting NO args"
    /sonarqube/bin/run.sh
else
    # echo "Starting WITH args"
    exec "$@"
fi