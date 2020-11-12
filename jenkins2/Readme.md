* Install Steps https://www.jenkins.io/doc/book/installing/war-file/
* Download from https://www.jenkins.io/download/ link is: https://get.jenkins.io/war-stable/2.249.2/jenkins.war
* https://docs.aws.amazon.com/corretto/latest/corretto-8-ug/generic-linux-install.html

## Build Image

```bash
cd $MY_WORKSPACE/docker/jenkins2
docker build -t rpradesh/jenkins2 .
```

## Test Image
```bash
docker run --rm -it rpradesh/jenkins2 bash
java -version
java -jar /usr/share/jenkins/jenkins.war



docker run --name j2_8060 -p 8060:8080 -d rpradesh/jenkins2
docker logs -f j2_8060
# chek is started 
docker logs -f j2_8060 | grep 'Jenkins is fully up and running'
# get admin pwd
docker exec j2_8060 cat /var/jenkins_home/secrets/initialAdminPassword
# oct22nd 2020 5aa61bf2f9c84fcda99f48d6771ded53
# Install Suggested Plugins - takes 1 min
# open browser and create user
# http://localhost:8060
# JK Admin jkadmin/jk@dmin 

date
java -version
which java

mongo --version
node -v
npm -v
ts-node -v

```
