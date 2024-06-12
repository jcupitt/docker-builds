# libvips 8.15 / ubuntu 22.04

```
docker pull ubuntu:jammy
docker build -t libvips-ubuntu22.04 .
docker run -it --rm -v $PWD:/data libvips-ubuntu22.04 
```
