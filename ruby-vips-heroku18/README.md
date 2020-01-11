# libvips on heroku 18

This uses platform libraries when we can. It builds to `/usr/local/vips` in the
container, so tar that up and send it off to s3 ready to deploy.

You'll need to add `/usr/local/vips/lib` to `LD_LIBRARY_PATH` so that 
ruby-vips can find `libvips.so.42`. 

Alternatively, you could just build to `/usr/local` and then I think you'd only
need `ldconfig` and no messing about with `LD_LIBRARY_PATH`.

This only builds some basic loaders, you might want to add webp, heic etc.

# Rebuild the image

```
docker pull heroku/heroku:18
docker build -t libvips-heroku18 .
```

# Shell in image

```
docker run -it --rm heroku/heroku:18
```

