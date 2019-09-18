# libvips with latest imagemagick + openjpeg on alpine

# Rebuild the image

```
docker pull alpine:latest
docker build -t libvips-openjpeg-alpine .
```

# Run

```
$ docker run --rm -it -v $HOME/pics:/data libvips-openjpeg-alpine bash
bash-5.0# identify 4888.jp2
4888.jp2 JP2 4368x2912 4368x2912+0+0 8-bit sRGB 0.000u 0:00.001
bash-5.0# vipsheader 4888.jp2
4888.jp2: 4368x2912 uchar, 3 bands, srgb, magickload
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
