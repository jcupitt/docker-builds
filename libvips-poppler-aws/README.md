# Make a libvips / poppler / amazonlinux stack

Dockerfile from https://github.com/libvips/libvips/issues/1749

# Rebuild the image

```
docker pull lambci/lambda:build-go1.x
docker build -t libvips-poppler-aws .
```

Look at result of libvips build:

```
docker run -it --rm --entrypoint /bin/bash 256d5013efd4
docker run -it --rm --entrypoint /bin/bash libvips-poppler-aws
```

