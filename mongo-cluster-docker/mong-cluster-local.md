* "SEARCH" - mongo cluster docker compose example
* https://github.com/senssei/mongo-cluster-docker Promising
* https://warzycha.pl/mongo-db-sharding-docker-example/
* https://www.sohamkamani.com/blog/2016/06/30/docker-mongo-replica-set/
*  https://takacsmark.com/docker-compose-tutorial-beginners-by-example-basics/

```bash
cd ~/projects/bb-poc
git clone https://github.com/senssei/mongo-cluster-docker.git
cd ~/projects/bb-poc/mongo-cluster-docker

docker-compose -f docker-compose.1.yml -f docker-compose.2.yml  -f docker-compose.cnf.yml -f docker-compose.shard.yml up
docker-compose -f docker-compose.1.yml -f docker-compose.2.yml  -f docker-compose.cnf.yml -f docker-compose.shard.yml up  -d --no-recreate --no-color 

docker-compose -f docker-compose.1.yml docker-compose.2.yml docker-compose.cnf.yml docker-compose.shard.yml  --detach --no-recreate --no-color  up

docker pull mongo:4.0.1
docker.io/library/mongo:4.0.1

```
* connect to  mongodb://localhost:30001
* https://docs.docker.com/compose/gettingstarted/

## Docker cheat sheet
- https://gist.github.com/jonlabelle/bd667a97666ecda7bbc4f1cc9446d43a
- https://medium.com/@soaple/develop-the-corona-dashboard-in-a-day-b5f1be41fe33

```text
var ops = db.currentOp({
    active: true,
    //waitingForLock : true,
    //secs_running : { $gt : 3 }, //longer than 3 seconds
    //$ownOps:true //returns information on the current user’s operations only.
    //$all:true, //including operations on idle connections and system operations
    //ns : /^db\.collection/
});

(ops.inprog || ops)
```

