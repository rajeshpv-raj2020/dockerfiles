* Basic Ubuntu 20.04 with minimum tools
  - Used as base image for other images
  - feature to pass any timeZone filename at start fo container
    - example: pass -e TZ_FILENAME=EST5EDT
  - feature to start container with any timestamp even using  "faketime" library
    - example: pass -e FAKETIME=-59d -e LD_PRELOAD=/lib/faketime.so -e DONT_FAKE_MONOTONIC=1 for chooisng your own timestamp in container

## Build Image
* Note: rpradesh/faketime:1.0.0 is already build or available in docker hub 

```bash
cd $MY_WORKSPACE/docker/ubuntu
docker build -t rpradesh/ubuntu20 .
```

## Validate Image
```bash
# Test.1: basic image, has default UTC timestamp
docker run --rm rpradesh/ubuntu20 date 

# Test.2: change choose any TimeZone
# first list available TimeZone Files
docker run --rm rpradesh/ubuntu20 ls /usr/share/zoneinfo 
# then pass to start container
docker run --rm -e TZ_FILENAME=EST5EDT rpradesh/ubuntu20 date

# Test.3: to change containers timestamp
# calculate diff days from current-time to 04/13/2020; we get -59 days
python -c "from datetime import date; print (date(2020,04,13)-date(2020,06,11)).days"

docker run --rm -e FAKETIME=-59d -e LD_PRELOAD=/lib/faketime.so -e DONT_FAKE_MONOTONIC=1 -it rpradesh/ubuntu20
# or
docker run --rm -e FAKETIME=-59d -e LD_PRELOAD=/lib/faketime.so -e DONT_FAKE_MONOTONIC=1 -e TZ_FILENAME=EST5EDT -it rpradesh/ubuntu20
# we notice time changes from above 04/13/2020 as start time, inside container
date
date
```

