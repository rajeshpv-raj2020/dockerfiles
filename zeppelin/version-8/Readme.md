## Reading
* Zeppelin Project - https://github.com/apache/zeppelin
* User Guide - https://zeppelin.apache.org/docs/latest/index.html
*  _Default Objects_  sc:SparkContext, sqlContext:SQLContext, z:ZeppelinContext, spark:SparkSession

## Build docker image
```bash
cd $MY_WORKSPACE/docker/zeppelin/version-8
docker build -t rpradesh/zeppelin:0.8.2 .
```

## Test Basic Image
* Let us launch basic Zeppelin and execute sample Spark Notebooks
```bash
docker run --network=local_network --name=zeppelin_082_1  -p 6082:9080 \
    -d rpradesh/zeppelin:0.8.2

docker logs -f zeppelin_082_1
# browse http://localhost:6082 login using admin/password1
# http://localhost:6082/#/notebook/2A94M5J1Z "spark" Basic Features Example

docker stop zeppelin_082_1 && docker rm zeppelin_082_1
```

### Volume mounts
  * -e SPARK_OUTPUT_DIR=/spark/output \
  * -v /docker-work/spark:/spark \
  * -v /Users/rajeshpradeshik/.m2:/m2 
  * where /spark/spark-jars/*.jar are copied to $SPARK_HOME/jars at startup

## Test Image usign Mount volume
  
```bash
mkdir -p /docker-work/zeppelin082/{logs,notebook}
# this has all jdbc or driver jars
ll /docker-work/spark/spark-jars

# start container usign above mount
docker run --network=local_network --name=zeppelin_082_2  -p 7082:9080 \
    -v /docker-work/zeppelin082/logs:/zeppelin/logs \
    -v /docker-work/zeppelin082/notebook:/zeppelin/notebook \
    -v /docker-work/spark:/spark \
    -v /Users/rajeshpradeshik/.m2:/m2  \
    -e SPARK_OUTPUT_DIR=/spark/output \
    -d rpradesh/zeppelin:0.8.2

docker logs -f zeppelin_082_2
docker stop zeppelin_082_2 && docker rm zeppelin_082_2

# Check zeppelin log
tail -f /docker-work/zeppelin082/logs/zeppelin-*.internal.log

# Check spark interpreter log
tail -f /docker-work/zeppelin082/logs/zeppelin-interpreter-spark*.log
```

### Commit Notebooks to GitHub
* Zeppelin creates git repo as storage for notebooks
* One can commit to another remote in github or bitbucket as follows
  
```bash
# one time add a remote
cd /docker-work/zeppelin082/notebook
git remote add 
# later commit as changes are made
ls -al
git add .
git commit -am "May 3 changes"
git push gitbackup master

```

#### Settings for Spark Interpreter
* restart interpreter, OK - after editing any settings
* zeppelin.dep.localrepo to /m2 - using above mount
* IF you want to point to spark-cluster change "local[*]" into master=spark://0.0.0.0:7077
* Put below for mongo as default - which does-not get used, but Mongo init needs it
* spark.mongodb.input.uri=mongodb://127.0.0.1:27997/tempdb.tempcol 
* spark.mongodb.output.uri=mongodb://127.0.0.1:27997/tempdb.tempcol
* spark.cores.max = 4, spark.executor.memory=8G
  * This will use only one worker's resource
* /spark/temp-app-jars/sparkapp1-assembly-0.0.5-SNAPSHOT.jar
* mongo.LOCAL.address     172.18.0.2:27017 dip mongo_32             
* mongo.LOCAL1.address    172.18.0.3:27017 dip mongo_eaa_v1         
* pg.LOCAL_PG.address     172.18.0.4:5432  dip localPostgres12 
*   "spark.sql.session.timeZone", "UTC"