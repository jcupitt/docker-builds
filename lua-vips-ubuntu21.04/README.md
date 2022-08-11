# lua-vi[ps on libvips master on ubuntu 21.04

```
docker pull ubuntu:21.04
docker build -t lua-vips-ubuntu21.04 .
docker run -it --rm -v $PWD:/data lua-vips-ubuntu21.04
```
