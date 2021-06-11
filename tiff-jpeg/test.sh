#!/bin/bash

docker run -t --rm -v $PWD:/data libvips-mozjpeg-ubuntu20.04 \
  vips copy stgall-sm.jpg \
    libvips-master_libtiff-master_mozjpeg-4.0.3.tif[compression=jpeg,tile]

