# libvips on heroku 22

This uses platform libraries when we can. It builds to `/usr/local/vips` in the
container, so tar that up and send it off to s3 or whatever ready to deploy.

# Rebuild the image

```
docker pull heroku/heroku:22
docker build -t libvips-heroku22 .
```

# TODO

- check the size of the binary tarball, and the size on disc
- strip a bit more?
- remove C++ libs and headers?
- pull the packaged tarball back out of the container 
