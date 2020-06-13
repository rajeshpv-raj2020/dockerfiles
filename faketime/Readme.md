* Building "faketime" library - to be used as library for other images

### Build Image and Test Base
* Copied shamelessly from https://github.com/trajano/ubuntu-faketime
* Read usage steps at https://github.com/wolfcw/libfaketime

```bash
cd $MY_WORKSPACE/docker/faketime
docker build -t rpradesh/faketime:1.0.0 .

# normal run
docker run --rm rpradesh/faketime:1.0.0 date

# calculate diff days from current-time to 04/13/2020
python -c "from datetime import date; print (date(2020,04,13)-date(2020,06,11)).days"

docker run --rm -e FAKETIME=-59d -e LD_PRELOAD=/lib/faketime.so -e DONT_FAKE_MONOTONIC=1 -it rpradesh/faketime:1.0.0
# we notice time changes from above 04/13/2020 as start time
date
date

```



