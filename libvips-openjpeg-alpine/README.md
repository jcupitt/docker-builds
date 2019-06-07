# libvips with latest imagemagick + openjpeg on alpine

# Rebuild the image

```
docker pull alpine:latest
docker build -t libvips-openjpeg-alpine .
```

# Run

```
docker run --rm -it -v $PWD:/data libvips-openjpeg-alpine bash
```

We see:

```
$ docker run --rm -it -v $PWD:/data libvips-openjpeg-alpine bash
bash-4.4# identify 517122.jp2 
517122.jp2 JP2 1808x1316 1808x1316+0+0 8-bit sRGB 0.000u 0:00.000
bash-4.4# convert 517122.jp2 x.png
bash-4.4# vipsheader 517122.jp2 
vipsheader: magickload: unsupported colorspace 19
bash-4.4# 
```

# Debug 

```
docker run \
  --security-opt seccomp=unconfined \
  --rm \
  -it libvips-openjpeg-alpine bash
apk add gdb glib-dbg
gdb vips
```
