# libvips / mozjpeg / ubuntu 18.10

# Rebuild the image

```
docker pull ubuntu:cosmic
docker build -t libvips-mozjpeg-ubuntu18.10 .
```

# Run "vipsthumbnail" from the container

```
docker run -it --rm -v $PWD:/data libvips-mozjpeg-ubuntu18.10
```

# Resize and test compression

With mozjpeg, basic JPG settings:

```
docker run -it --rm -v $PWD:/data libvips-mozjpeg-ubuntu18.10 \
  pic.jpeg --size=1920x1280 \
  -o pic-mozjpeg-basic.jpg[Q=90,optimize_coding,strip,interlace]
```

No mozjpeg, basic settings:
  
```
vipsthumbnail pic.jpeg --size=1920x1280 \
  -o pic-jpeg-basic.jpg[Q=90,optimize_coding,strip,interlace]
```

With Imagemagick:

```
convert pic.jpeg -resize 1920x1280 -quality 90 -interlace plane -strip \
  pic-imagick.jpg
```

Try trellis quantisation:

```
docker run -it --rm -v $PWD:/data libvips-mozjpeg-ubuntu18.10 \
  pic.jpeg --size=1920x1280 \
  -o pic-mozjpeg-basic.jpg[Q=90,optimize_coding,strip,interlace,trellis-quant]
```
  
