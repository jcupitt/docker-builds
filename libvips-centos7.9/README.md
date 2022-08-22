# libvips on centos 7

# Rebuild the image

```
docker pull centos:7
docker build -t libvips-centos7.9 .
docker run -it --rm -v $PWD:/data libvips-centos7.9 
```



