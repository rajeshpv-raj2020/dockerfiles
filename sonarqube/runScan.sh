#!/usr/bin/env bash

curPwd="$(pwd)"
lastDirName="$(basename $curPwd)"
arg1=$1
projectKey=${arg1:=$lastDirName}

mvn org.jacoco:jacoco-maven-plugin:prepare-agent verify sonar:sonar \
    -Dsonar.host.url=http://127.0.0.1:9000 \
    -Dsonar.ws.timeout=300 \
    -Dmaven.test.failure.ignore=true \
    -Dsonar.projectKey=$projectKey -Dsonar.projectName=$projectKey