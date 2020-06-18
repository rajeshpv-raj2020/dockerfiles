## Build docker image
* Followed install from https://spark.apache.org/docs/latest/
* Base image rpradesh/scala:2.12.8 has java 8, python3, scala 2.12.8
* Requirements from https://spark.apache.org/docs/latest/#downloading

## Build Image
```bash
cd $MY_WORKSPACE/docker/spark
docker build -t rpradesh/spark:2.4.6  .
```

## About Data Volumes
* /spark volume is avialble to be mounted
* if mounted, the jar files inside /spark/app-jars/*.jar and /spark/spark-jars/*.jar gets copied over into $SPARK_HOME/jars folder
* there is /spark/output too where the stdoutput is redirected to 

## Test Image; using spark-shell
* We will run spark job using spark-shell
* https://spark.apache.org/docs/latest/#running-the-examples-and-shell
  
```bash
docker run --rm -it rpradesh/spark:2.4.6 bash

./bin/run-example SparkPi 10
```

## To Start Standalone Cluster
* Start master and workeers and submit job
```bash
# one can use this alias for getting docker container's IP 
alias dip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

mkdir -p /docker-work/spark/{output,spark-jars,app-jars,temp-app-jars}

# start master
docker run --network=local_network  --name=spark_master_1 \
   -p 3040:3040 -p 7077:7077 -p 8077:8077 \
   -d rpradesh/spark:2.4.6

docker logs -f spark_master_1

# start 2 workers
docker run --network=local_network --name=spark_workers_2set  -p "8053-8055:8053-8055" \
    -e SPARK_MASTER_HOSTIP=$(dip spark_master_1) \
    -e SPARK_WORKER_WEBUI_PORT=8053 \
    -e SPARK_WORKER_INSTANCES=2 \
    -d rpradesh/spark:2.4.6

docker logs -f spark_workers_2set
```   

* Browse master and worker status monitor at http://localhost:8077
* https://spark.apache.org/docs/latest/submitting-applications.html#launching-applications-with-spark-submit

```bash
# start simple bash shell and submit using spark-submit to above cluster
docker run --rm --network=local_network -it rpradesh/spark:2.4.6 bash

# submit job locally
./bin/spark-submit --master local[8] \
  --class org.apache.spark.examples.SparkPi \
  ./examples/jars/spark-examples_2.11-2.4.6.jar 100

# submit job to Spark Cluster we created above
./bin/spark-submit --master spark://docker.for.mac.localhost:7077 \
  --class org.apache.spark.examples.SparkPi \
  ./examples/jars/spark-examples_2.11-2.4.6.jar 100

# you notice there is an "Completed Application" in http://localhost:8077/

docker stop spark_workers_2set
docker stop spark_master_1

docker rm spark_workers_2set
docker rm spark_master_1

```
