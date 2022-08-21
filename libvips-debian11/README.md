# libvips stable on debian 11

```
docker pull debian:11
docker build -t libvips-debian11 .
docker run --rm -it -v $PWD:/data libvips-debian11
```
