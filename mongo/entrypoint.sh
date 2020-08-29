#!/usr/bin/env bash

# /setTimeZone.sh

function copyFromBackup(){
    # if already not copied then only copy
    if [[ ! -f "/copyFromBackup.done" ]]; then
        # if var is not empty
        if [[ ! -z "$COPY_DATA_FROM" ]]; then
            #if given path exists by means of volume or mount , copy it
            if [[ -d "$COPY_DATA_FROM" ]]; then
                echo $(date) > /copyFromBackup.done
                cd $COPY_DATA_FROM
                cp -R . /var/lib/mongodb  
                cd -              
                echo "copy completed"
            fi
        fi
    fi
}

if [[ -z "$@" ]]; then
    # echo "Starting NO args"
    mkdir -p /var/log/mongodb
    copyFromBackup
    touch /var/log/mongodb/mongod.log
    /usr/bin/mongod --bind_ip 0.0.0.0 --config /etc/mongod.conf --fork --logpath /var/log/mongodb/mongod.log > mongod.out 2>&1
    tail -f /var/log/mongodb/mongod.log
else
    # echo "Starting WITH args"
    exec "$@"
fi
