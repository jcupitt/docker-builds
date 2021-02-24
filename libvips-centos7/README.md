# Make a libvips for centos 7

```
docker pull centos:centos7
docker build -t libvips-centos7 .
docker run -it --rm -v $PWD:/data libvips-centos7:latest \
    /usr/local/bin/vips-8.10 vips dzsave /data/CMU-1.svs /data/x
docker run -it --rm -v $PWD:/data libvips-centos7:latest \
    /usr/local/bin/vips-8.10 vips openslideload /data/CMU-1.svs /data/test.dz --autocrop --vips-progress

```




