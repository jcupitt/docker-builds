# Make a libvips for centos 7.2

```
docker pull centos:centos7.2.1511
docker build -t libvips-centos7.2 .
docker run -it --rm -v $PWD:/data libvips-centos7.2:latest \
    /usr/local/bin/vips-8.9 vips dzsave /data/CMU-1.svs /data/x
docker run -it --rm -v $PWD:/data libvips-centos7.2:latest \
    /usr/local/bin/vips-8.9 vips openslideload /data/CMU-1.svs /data/test.dz --autocrop --vips-progress

```




