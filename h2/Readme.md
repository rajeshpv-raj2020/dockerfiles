* Uses rpradesh/openjdk8 as base image  
* The image provides tcp port for jdbc connection
* And it provides web interface to query like a sql client

## Build Image
* List the version of jars available in maven using, and pas the build argument
* https://repo1.maven.org/maven2/com/h2database/h2/
* https://repo1.maven.org/maven2/com/h2database/h2/1.4.200/h2-1.4.200.jar
  
```bash
cd $MY_WORKSPACE/docker/h2
docker build --build-arg H2_VERSION=1.4.200   -t rpradesh/h2 .
```

## Test Image - with default ENV values
```bash
docker run --name h2_1 -p 9032:9032 -p 8032:8032 -d rpradesh/h2 
# check logs for how to connect using
docker logs h2_1

```

## Test Image - using NEW ENV values
```bash
docker run --name h2_2 -p 9032:9032 -p 8032:8032 \
  -e DB_NAME=mongo_metrics_db -e DB_USER=dbuser -e DB_PWD=db@pwd \
  -d rpradesh/h2 
# check logs for how to connect using
docker logs h2_2

# or to mount data folder use
-v `pwd`:/h2

docker run --name h2_9033 -p 9033:9032 -p 8033:8032 \
  -v /docker-work/h2_9033:/h2 \
  -e DB_NAME=mongo_metrics_db -e DB_USER=dbuser -e DB_PWD=db@pwd \
  -d rpradesh/h2

mkdir -p /docker-work/h2_9033
  docker cp h2_2:/h2/mongo_metrics_db.mv.db /docker-work/h2_9033
  docker cp h2_2:/h2server.created /docker-work/h2_9033

ll /docker-work/h2_9033
docker logs h2_9033

cat /docker-work/h2_9033/h2server.created
# 
```

## Connect using
* Open client web at http://localhost:8033  Driver Class=org.h2.Driver
* jdbclURL=jdbc:h2:tcp://host.docker.internal:9033//h2/mongo_metrics_db
* dbuser/db@