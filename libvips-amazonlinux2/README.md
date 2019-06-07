# Make a libvips for amazonlinux:2

This Dockerfile also builds libwebp from source, since the one bundles
with amz is too old. There are probably better ways of getting an up to
date libwebp.

# Rebuild the image

```
docker pull amazonlinux:2
docker build -t libvips-amazonlinux:2 .
```


