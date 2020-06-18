 Uses rpradesh/ubuntu:20.04.0 as base image  
* Has Amazon Corretto JDKs 11 and Scala 2.12.8 
* Ofcourse with faketime feature from base Ubuntu image

## Build Image
```bash
cd $MY_WORKSPACE/docker/scala
docker build \
    --build-arg SCALA_VERSION=2.12.8 \
    -t rpradesh/scala:2.12.8 .
```

## Test Image
* Validate TimeZone is UTC by default
```bash
docker run --rm -it rpradesh/scala:2.12.8 bash
date
java -version
which java
scala -version
which scala

# validate faketime for java
docker run --rm -e TZ_FILENAME=EST5EDT \
  -e FAKETIME=-59d -e LD_PRELOAD=/lib/faketime.so -e DONT_FAKE_MONOTONIC=1 \
  -it rpradesh/scala:2.12.8 bash
  
scala -e "println(new java.util.Date())"
```

### Notes:
* Latest JAVA versions from here
  - https://github.com/corretto/corretto-11/releases 11.0.7.10.1
* Scala version from https://www.scala-lang.org/download/ which is 2.12.8
