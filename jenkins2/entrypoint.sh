#!/usr/bin/env bash


if [[ -z "$@" ]]; then
    java -jar /usr/share/jenkins/jenkins.war
else
    # echo "Starting WITH args"
    exec "$@"
fi
