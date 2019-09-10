# libvips / mozjpeg / ubuntu 18.10

# Rebuild the image

```
docker pull ubuntu:cosmic
docker build -t libvips-mozjpeg-ubuntu18.10 .
```

# Run the test script

```
$ ./test.sh 
imagemagick, system libjpeg ...
-rw-r--r-- 1 john john 516331 Sep 10 14:41 pic-imagick.jpg
libvips with mozjpeg --Q=85 ... 0.88
-rw-r--r-- 1 root root 518535 Sep 10 14:41 'pic-mozjpeg-Q=85.jpg'
libvips with mozjpeg --optimize-scans ... 1.09
-rw-r--r-- 1 root root 515515 Sep 10 14:41 pic-mozjpeg-optimize-scans.jpg
libvips with mozjpeg --trellis-quant ... 1.08
-rw-r--r-- 1 root root 473371 Sep 10 14:41 pic-mozjpeg-trellis-quant.jpg
libvips with mozjpeg --overshoot-deringing ... 0.82
-rw-r--r-- 1 root root 518954 Sep 10 14:41 pic-mozjpeg-overshoot-deringing.jpg
```

1. With no options, mozjpeg gives similar results to the system libjpeg
   (libjpeg-turbo in this case): 516331 and 518535 bytes.
2. `optimize-scans` adds about 200ms of runtime and saves 3kb.
4. `trellis-quant` also adds about 200ms of runtime and saves 46kb.
5. `overshoot-deringing` is free and does not affect filesize.

# Run "vipsthumbnail" from the container

```
docker run -it --rm -v $PWD:/data libvips-mozjpeg-ubuntu18.10
```

# Open shell in container

```
docker run -it --rm -v $PWD:/data --entrypoint /bin/bash \
  libvips-mozjpeg-ubuntu18.10 
```
