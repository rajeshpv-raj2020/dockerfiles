* Uses rpradesh/ubuntu:20.04.0 as base image  
* Has Amazon Corretto JDKs 8 and 11, with latest Maven and Groovy
* Ofcourse with faketime feature from base Ubuntu image

## Build Image
```bash
cd $MY_WORKSPACE/docker/javamvn
docker build --build-arg JAVA_AWS_VERSION=8.252.09.1   -t rpradesh/javamvn:8.252.09  .
docker build --build-arg JAVA_AWS_VERSION=11.0.7.10.1  -t rpradesh/javamvn:11.0.7 .
```

## Test Image
* Validate TimeZone is UTC by default
```bash
# docker run --rm -it rpradesh/javamvn:8.252.09 bash
# or 
docker run --rm -it rpradesh/javamvn:11.0.7 bash
date
java -version
mvn -version
groovy -version
which java

# validate faketime for java
docker run --rm -e TZ_FILENAME=EST5EDT \
  -e FAKETIME=-59d -e LD_PRELOAD=/lib/faketime.so -e DONT_FAKE_MONOTONIC=1 \
  -it rpradesh/javamvn:8.252.09 bash
  
groovy -e "print new Date();"

# copy settings file and test mvn
docker cp your-own-settings.xml containerid:/apache-maven-3.6.3/conf/settings.xml
```

### Notes:
* Latest JAVA versions from here
  - https://github.com/corretto/corretto-8/releases  8.252.09.1
  - https://github.com/corretto/corretto-11/releases 11.0.7.10.1
* Maven version from https://us.mirrors.quenda.co/apache/maven/maven-3/ which 3.6.3
* Goovy version from http://groovy-lang.org/download.html which is 3.0.4

