# ruby-vips / libvips / openslide / ubuntu 18.04

# Rebuild the image

    docker pull ubuntu:bionic

    docker build -t pyvips-libvips-openslide-ubuntu18.04 .

    docker run -it --rm -v $PWD:/data pyvips-libvips-openslide-ubuntu18.04



