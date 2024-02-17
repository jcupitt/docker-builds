# libvips / mozjpeg / ubuntu 23.10

# Rebuild the image

```
docker pull ubuntu:23.10
docker build -t libvips-mozjpeg-ubuntu23.10 .
```

# Test

```
docker run -it --rm -v $PWD:/data --entrypoint /bin/bash \
  libvips-mozjpeg-ubuntu23.10
```
