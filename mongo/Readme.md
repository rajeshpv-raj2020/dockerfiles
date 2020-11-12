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
docker run  --rm -it rpradesh/mongo:3.2.22 mongo --port 27017 --host docker.for.mac.localhost

# Test.3.1: Launch Shell
docker run  --rm --network=local_network -it rpradesh/mongo:3.2.22 bash

4288204433

```

## New Mongo Image - BUILD
```bash
cd $MY_WORKSPACE/docker/mongo
docker build -t rpradesh/mongo322 .
```

## Steps to BACKUP and RETRIEVE data into new Mongo Container
* Helps to generate common set of data or seed data in a volume and use it to boot into any mongo container
* Consider your app name is "eaa" (example)
  
### Step 1:
* You might have a mongo instance already running or newly started as follows
```bash
docker run --name mongo322_eaa  -p 27029:27017 -d rpradesh/mongo322

docker exec -it mongo322_eaa bash
mongo --quiet
# let us create data in above mongo container
db.getSiblingDB("dbstore").getCollection("col_1").insertOne({appName: "eaa 1" });
db.getSiblingDB("dbstore").getCollection("col_1").insertOne({nowDate: new Date() });
db.getSiblingDB("dbstore").getCollection("col_1").find({});
exit

```

### Step 2 - create a volume holder
* If our wish is to copy data from "mongo322_eaa" into new "mongo322_eaa_2" container 
* First create a volume in app called "eaa"

```bash
docker volume create mongo_eaa_vol
```

### Step 3 - one time backup
* we will use following command to copy data to volume
* Note for proper snapshot to be taken, the inflight transcations might be missed
```bash  
docker run --rm --volumes-from  mongo322_eaa -v mongo_eaa_vol:/mongo-backup -it ubuntu /bin/bash -c "cp -R /var/lib/mongodb/* /mongo-backup"
```

### Step 4 - copying from volume to new container
* we can copy data into any number of new containers
* Say we want to copy data from backup volume called "mongo_eaa_vol" into "mongo322_eaa_2" container
* Also the mongo container takes care of handling restarts - not to RE-copy data at "docker start"
* Data is copied from backup volume only at first docker-run
  
```bash
docker run --name mongo322_eaa_2 -v mongo_eaa_vol:/mongo-backup -e COPY_DATA_FROM=/mongo-backup -p 27039:27017 -d rpradesh/mongo322

# as a client let us check data in new container to validate copy is done
docker exec -it mongo322_eaa_2 bash
mongo --quiet --eval 'db.getSiblingDB("dbstore").getCollection("col_1").find({});'
```
