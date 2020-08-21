# Make a libvips for centos 6.9

```
docker pull centos:centos6.9
docker build -t libvips-centos6.9 .
docker run -it --rm -v $PWD:/data libvips-centos6.9:latest \
    /usr/local/bin/vips-8.10 vips dzsave /data/CMU-1.svs /data/x
docker run -it --rm -v $PWD:/data libvips-centos6.9:latest \
    /usr/local/bin/vips-8.10 vips openslideload /data/CMU-1.svs \
       /data/test.dz --autocrop --vips-progress
```




