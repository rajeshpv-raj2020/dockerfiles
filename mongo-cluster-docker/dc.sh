#!/usr/bin/env bash

defaultCmd=" -f docker-compose.1.yml -f docker-compose.2.yml  -f docker-compose.cnf.yml -f docker-compose.shard.yml "


# ./dc.sh up  -d --no-recreate --no-color
# ./dc.sh ps
# ./dc.sh stop
# ./dc.sh start


echo 'Executing cmd ....' docker-compose $defaultCmd $@

docker-compose $defaultCmd $@