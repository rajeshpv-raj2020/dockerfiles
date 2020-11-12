#!/usr/bin/env bash


if [[ -z "$@" ]]; then
    java -Duser.home="$JENKINS_HOME" -jar /usr/share/jenkins/jenkins.war
else
    # echo "Starting WITH args"
    exec "$@"
fi
