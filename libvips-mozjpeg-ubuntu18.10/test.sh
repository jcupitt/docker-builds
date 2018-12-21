#!/bin/bash

# use quality 85 everywhere ... higher quality settings will automatically
# disable chroma subsampling for IM and libvips 

# some imagemagicks will never disable chroma subsample for this image, force
# it off
convert pic.jpeg -resize 1920x1280 \
  -quality 85 -interlace plane -strip -sampling-factor "2x2, 1x1, 1x1" \
  pic-imagick.jpg

# basic libvips save options to match the above 
options=Q=85,optimize-coding,strip,interlace

# the Q=85 one does nothing and will just match the imagic settings
for moz_option in Q=85 optimize-scans trellis-quant overshoot-deringing; do
  docker run -it --rm -v $PWD:/data libvips-mozjpeg-ubuntu18.10 \
    pic.jpeg --size=1920x1280 \
    -o pic-mozjpeg-$moz_option.jpg[$options,$moz_option]
done

