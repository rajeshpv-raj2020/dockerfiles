* Uses rpradesh/ubuntu as base image
* Installs Node 12 latest version


## Build Image
```bash
cd $MY_WORKSPACE/docker/node
docker build -t rpradesh/node12 .
```

## Test Image
```bash
docker run --rm -it rpradesh/node12 node -v

```

