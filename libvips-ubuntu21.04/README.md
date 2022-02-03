# libvips master / ubuntu 21.04

```
docker pull ubuntu:21.04
docker build -t vips-test .
docker run -it --rm -v $PWD:/data vips-test
```
