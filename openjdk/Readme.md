* Uses rpradesh/ubuntu:20.04.0 as base image  
* Has Adopt OpenJdk 8 with latest Maven and Groovy
* Ofcourse with faketime feature from base Ubuntu image

## Build Image
```bash
cd $MY_WORKSPACE/docker/openjdk
docker build  -t rpradesh/openjdk8 .
```

## Test Image
* Validate TimeZone is UTC by default
```bash
docker run --rm -it rpradesh/openjdk8 bash
date
java -version
mvn -version
groovy -version
which java

# validate faketime for java
docker run --rm -e TZ_FILENAME=EST5EDT \
  -e FAKETIME=-59d -e LD_PRELOAD=/lib/faketime.so -e DONT_FAKE_MONOTONIC=1 \
  -it rpradesh/openjdk8 bash
  
groovy -e "print new Date();"

# copy settings file and test mvn
docker cp your-own-settings.xml containerid:/apache-maven-3.6.3/conf/settings.xml
```

## OR Pull from docker hub
```bash
docker pull rpradesh/openjdk8
mkdir -p /docker-work/M2-REPO

docker run --name m2 --rm -e TZ_FILENAME=UTC -v /docker-work/M2-REPO:/M2-REPO -v `pwd`:/code -it rpradesh/openjdk8

docker cp $MY_WORKSPACE/docker/openjdk/my-settings.xml m2:/apache-maven-3.6.3/conf/settings.xml
docker cp $MY_WORKSPACE/docker/openjdk/etc-default-locale m2:/etc/default/locale

cd /code
cat /etc/default/locale
ll
groovy -e "print new Date();"
#mvn clean compile
export LC_ALL=C
```

### Notes:
* Latest JAVA versions from here https://adoptopenjdk.net/releases.html?variant=openjdk8&jvmVariant=hotspot
* https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01/OpenJDK8U-jdk_x64_linux_hotspot_8u265b01.tar.gz
* Maven version from https://us.mirrors.quenda.co/apache/maven/maven-3/ which 3.6.3
* Goovy version from http://groovy-lang.org/download.html which is 3.0.4

