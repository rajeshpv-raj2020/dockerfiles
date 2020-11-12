* Image extends base from FROM centos:centos7
* https://docs.docker.com/docker-for-mac/networking/#use-cases-and-workarounds

## Build Image
```bash
cd $MY_WORKSPACE/docker/mongoclient
docker build --build-arg MONGO_VER=3.2   -t rpradesh/mongoclient:3.2  .
docker build --build-arg MONGO_VER=4.0   -t rpradesh/mongoclient:4.0  .
```

## Test Image
```bash
docker run --name=mserver32 --network=local_network -p 27027:27017 -d rpradesh/mongo322
docker logs -f mserver32
 
# test with and without network
docker run --rm -it rpradesh/mongoclient:3.2 mongo --quiet --port 27027 --host docker.for.mac.localhost

# using host
docker run --rm -it rpradesh/mongoclient:3.2 mongo --quiet --port 27027 --host host.docker.internal
```

### Mongo script
```text
db.getSiblingDB('test').getCollection('test_col').insertOne({dateNow: new Date()});
db.getSiblingDB('test').getCollection('test_col').find({});


show dbs
use local
show collections
db.getSiblingDB('local').getCollection('startup_log').find({});
Ctrl+D or exit 

```


* test with network
```bash
docker run --name=mserver32_second --network=local_network -p 27037:27017 -d rpradesh/mongo322
docker run --rm --network=local_network -it rpradesh/mongoclient:3.2 mongo 
```

