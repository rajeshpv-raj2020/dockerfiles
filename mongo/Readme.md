* Basic Ubuntu 16.04 with Mongo 3.2.22 version ( as Mongo 3.2 runs on Xenial version)
* One can check version available at mongodb.org http://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/4.2
* exposed volumes: /var/log/mongodb and /var/lib/mongodb port:27017
  
## Build 3.2.22 Image
* Followed https://docs.mongodb.com/v3.2/tutorial/install-mongodb-on-ubuntu/ to create Mongo db 3.2
```bash
cd $MY_WORKSPACE/docker/mongo
docker build -t rpradesh/mongo:3.2.22 .
```

## Build 4.2.8 Image
* Followed https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/ to create 4.2.8
```bash
cd $MY_WORKSPACE/docker/mongo
docker build -f Dockerfile42 -t rpradesh/mongo:4.2.8 .
```
  
## Validate MongoD 3.2.22
```bash
# Test.1: start mongod with UTC TimeZone
docker run --name=mongo32_1 --network=local_network -p 27019:27017 -d rpradesh/mongo:3.2.22 
docker logs -f mongo32_1

# to stop and/or remove
docker stop mongo32_1
docker rm mongo32_1

# Test.1.1: start mongod with volume 
mkdir -p /docker-work/data/mongo32_2/data

docker run --name=mongo32_2 --network=local_network -p 27029:27017 \
  -v /docker-work/data/mongo32_2/lib:/var/lib/mongodb \
  -d rpradesh/mongo:3.2.22 

  ll /docker-work/data/mongo32_2/lib
```

## Validate MongoD 4.2.8
```bash
# Test.1: start mongod with UTC TimeZone
docker run --name=mongo42_1 --network=local_network -p 27049:27017 -d rpradesh/mongo:4.2.8
docker run  --rm -it rpradesh/mongo:4.2.8 mongo --port 27049 --host docker.for.mac.localhost --quiet

```

## Validate Mongo Shell
```bash
# Test.2.1: from host mongo shell
mongo --port 27019

# Test.2.2: from mogo container using direct ip
docker inspect mongo32_1 | grep IPAddress
docker run  --rm --network=local_network -it rpradesh/mongo:3.2.22 mongo --port 27017 --host 172.18.0.2

show databases
use local
show collections
db.person.insertOne({name: "John Smith"});
db.person.find({});

# Test.2.3: using docker.for.mac.localhost or windows; is the IP visible to containers alone
docker run  --rm -it rpradesh/mongo:3.2.22 mongo --port 27019 --host docker.for.mac.localhost

# Test.3.1: Launch Shell
docker run  --rm --network=local_network -it rpradesh/mongo:3.2.22 bash

```