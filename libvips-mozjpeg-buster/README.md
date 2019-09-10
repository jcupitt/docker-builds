# Dockerfile for mozjpeg tests

Dockerfile based on this gist:

https://gist.github.com/adityapatadia/ee2312f92dd60aee741e2f9e71965b94

# Build container

```
docker pull node:12.8-buster
docker build -t libvips-mozjpeg-buster .
```

# Run test

```
$ ./test.sh 
imagemagick, system libjpeg ...
-rw-r--r-- 1 john john 516331 Sep 10 15:16 pic-imagick.jpg
libvips with mozjpeg --Q=85 ... 0.90
-rw-r--r-- 1 root root 518535 Sep 10 15:16 'pic-mozjpeg-Q=85.jpg'
libvips with mozjpeg --optimize-scans ... 1.05
-rw-r--r-- 1 root root 515515 Sep 10 15:16 pic-mozjpeg-optimize-scans.jpg
libvips with mozjpeg --trellis-quant ... 1.07
-rw-r--r-- 1 root root 473371 Sep 10 15:16 pic-mozjpeg-trellis-quant.jpg
libvips with mozjpeg --overshoot-deringing ... 0.90
-rw-r--r-- 1 root root 518954 Sep 10 15:16 pic-mozjpeg-overshoot-deringing.jpg
```
