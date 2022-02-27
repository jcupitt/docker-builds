# libvips on heroku 18

This uses platform libraries when we can. It builds to `/usr/local` so
ruby-ffi can find libvips immediately.

# Rebuild the image

```
docker pull heroku/heroku:18
docker build -t libvips-heroku18-build .
```

Extract the tar file with:

```
docker run --rm --rm --entrypoint /bin/sh libvips-heroku18-build \
    -c "cat /usr/local/libvips-heroku18.tar.gz" \
    > libvips-heroku18.tar.gz
```

Test with:

```
docker build -t libvips-heroku:18 -f Dockerfile.test
```


# Dependencies

None, it should work on the bare heroku:18 image. You will need ruby-dev for
ffi, of course.

# Supported formats

- **JPEG** load and save with platform libjpeg-turbo and libexif
- **PNG** load with included libspng, save with platform libpng
- **WEBP** load and save with platform libwebp
- **TIFF** load and save with platform libtiff
- **GIF** load with included libnsgif, save with included cgif
- **SVG** load with platform librsvg
- **PDF** load with latest PDFium
- **PPM / PGM / PBM** load and save
- **DeepZoom / Google maps / Zoomify save** with included libgsf
- **CSV** load and save
- **MAT** (ascii matrix file) load and save
- **VIPS** load and save

# Features

- **Text rendering** with platform pangocairo
- **Colour management** with platform lcms2
- **Fourier transforms** with platform fftw3
- **Palette quantization and dithering** with included libimagequant 2.4
- **Run-time code generation** with included liborc

# Missing features

- **HEIF / HEIC / AVIF** I've not tried to build these, it would be possible,
  but they need a lot of code
- **JXL** I've not built this, it's still too young for production use, in my
  opinion
- **vips7 compatibility** Disabled since ruby-vips doesn't need it
- **Analyze** Few people need this, so it's disabled
- **Radiance** Few people need this, so it's disabled
