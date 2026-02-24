# libvips / ubuntu 25.10

# Rebuild the image

```
docker pull ubuntu:25.10
docker build -t nip4-libvips-ubuntu25.10 .
```

# Test

```
docker run -it --rm -v $PWD:/data --entrypoint /bin/bash \
  nip4-libvips-ubuntu25.10
```
