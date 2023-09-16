# libvips on heroku 22

This uses platform libraries when we can. It builds to `/usr/local/vips` in the
container, so tar that up and send it off to s3 or whatever ready to deploy.

# Rebuild the image

```
docker pull heroku/heroku:22
docker build -t libvips-heroku22 .
```

# TODO

- pull the packaged tarball back out of the container 
