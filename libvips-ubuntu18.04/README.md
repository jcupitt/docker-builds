# libvips 8.8 / ubuntu 18.04

19.04 has a pandoc package that breaks some of the doc formatting. Build on
18.04 LTS to get a complete set of docs.

# Rebuild the image

```
docker pull ubuntu:bionic
docker build -t libvips-ubuntu18.04 .
docker run -it --rm -v $PWD:/data libvips-ubuntu18.04 
```


