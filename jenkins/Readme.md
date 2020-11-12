* Uses jenkins/jenkins:lts as base image  os is debian
* 
* 

## Build Image

```bash
cd $MY_WORKSPACE/docker/jenkins
docker build -t rpradesh/jenkins .
```

## Test Image
```bash

docker run --name j1_8040 --rm -it -p 8040:8080 rpradesh/jenkins bash
pwd
java -version
java -Duser.home="$JENKINS_HOME" -jar /usr/share/jenkins/jenkins.war

# check
date
java -version
which java

mongo --version
node -v
npm -v
ts-node -v

```

## Launch Jenkins Daemon
```bash
docker run --name j1_8070 -p 8070:8080 -d rpradesh/jenkins
docker logs -f j1_8070

# chek is started 
docker logs -f j1_8070 | grep 'Jenkins is fully up and running'

# get admin pwd
docker exec j1_8070 cat /var/jenkins_home/secrets/initialAdminPassword
# oct22nd 2020 60d32076da5147cd910d072c9b8e8dc4

```

## Manual Steps
* Open http://localhost:8070 and first tim eget above long-admin password
* Install Default Plugins + Ocean agg - plugin - (one time)
* Create Admin User ( JK Admin jkadmin/jk@dmin)

```bash

docker commit a8a73daee8ac rpradesh/jenkins:plugins_installed

docker stop j1_8070

docker run --name j11_8075 -p 8075:8080 -d rpradesh/jenkins:plugins_installed
docker logs -f j11_8075
docker stop j11_8075
# Commiting into new image is NOT working
```

### Configs
* start old container docker start j1_8070
* Install "Blue Ocean Theme Plugin"
* From jenkins-setup-steps.md create dataimport.env and npmr
