# Make a libvips for amazonlinux:2

This builds libvips and libwebp to a private prefix (usr/local/vips). You can
tar this up and copy the tree to other machines that might need it.

This Dockerfile also builds libwebp from source, since the one bundles
with amz is too old. There are probably better ways of getting an up to
date libwebp.

# Rebuild the image

```
docker pull amazonlinux:2
docker build -t libvips-amazonlinux:2 .
```


