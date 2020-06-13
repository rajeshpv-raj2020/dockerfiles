#!/usr/bin/env bash

/setTimeZone.sh

if [[ -z "$@" ]]; then
    # echo "Starting NO args"
    bash
else
    # echo "Starting WITH args"
    exec "$@"
fi
